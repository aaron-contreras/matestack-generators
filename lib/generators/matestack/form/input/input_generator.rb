# frozen_string_literal: true

require 'rails/generators/base'
require_relative '../constants'

module Matestack
  module Form
    class InputGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)
  
      argument :name, type: :string
      class_option :registry, type: :boolean, default: true, desc: 'Add to the Component Registry'
      class_option :full, type: :boolean, default: false, desc: 'Generate a "fully-featured" component'
  
      include Constants
  
      def setup_generator_config
        @ruby_component_config = {}.tap do |config|
          config[:template_file_path] = "ruby_component#{TEMPLATE_FILE_TYPE}"
          config[:file_path] = "#{COMPONENT_DIRECTORY}/#{name.underscore}#{RUBY_FILE_TYPE}"
          config[:klass] = ['Components', name.split('/')].flatten.map(&:camelcase).join('::')
          config[:base_klass] = 'Matestack::Ui::VueJs::Components::Form::Input'
          config[:helper_name] = name.split('/').map(&:underscore).join('_') if options[:registry]
        end
  
        @vue_js_component_config = {}.tap do |config|
          config[:template_file_path] = "vue_js_component#{VUE_JS_TEMPLATE_FILE_TYPE}"
          config[:file_path] = "#{COMPONENT_DIRECTORY}/#{name.underscore}#{JAVASCRIPT_FILE_TYPE}"
          config[:component_name] = name.gsub('/', '_').camelize(:lower)
          config[:registry_name] = name.gsub(%r{/|_}, '-')
        end
      end
  
      def generate_ruby_matestack_component
        template @ruby_component_config[:template_file_path], @ruby_component_config[:file_path]
      end
  
      def generate_vue_js_matestack_component
        template @vue_js_component_config[:template_file_path], @vue_js_component_config[:file_path]
      end
  
      def register_component_helper_method
        if options[:registry] && File.exist?(REGISTRY_DEFAULT_FILE_PATH)
          inject_into_file 'app/matestack/components/registry.rb', after: "module Components::Registry\n" do
            <<-RUBY.gsub(/^ {12}/, '')
                def #{@ruby_component_config[:helper_name]}(text=nil, options=nil, &block)
                  #{@ruby_component_config[:klass]}.call(text, options, &block)
                end
            RUBY
          end
        end
      end
  
      def register_on_package_manager
        if importmap?
          ensure_eof_newline_on('config/importmap.rb')
  
          append_to_file 'config/importmap.rb' do
            pin_component(
              registry_name: @vue_js_component_config[:registry_name],
              file_path: @vue_js_component_config[:file_path]
            )
          end
  
          inject_into_file 'app/javascript/application.js', before: APP_INSTANCE_REGISTRATION do
            pack_file_component_import(
              component_name: @vue_js_component_config[:component_name],
              component_path: @vue_js_component_config[:registry_name]
            )
          end
  
          inject_into_file 'app/javascript/application.js', after: APP_INSTANCE_REGISTRATION do
           pack_file_component_registration(
            app_instance_name: app_instance_name('app/javascript/application.js'),
            registry_name: @vue_js_component_config[:registry_name],
            component_name: @vue_js_component_config[:component_name]
           )
          end
        elsif webpacker?
          inject_into_file 'app/javascript/packs/application.js', before: APP_INSTANCE_REGISTRATION do
            pack_file_component_import(
              component_name: @vue_js_component_config[:component_name],
              component_path: "../../../#{@vue_js_component_config[:file_path]}"
            )
          end
  
          inject_into_file 'app/javascript/packs/application.js', after: APP_INSTANCE_REGISTRATION do
            pack_file_component_registration(
              app_instance_name: app_instance_name('app/javascript/packs/application.js'),
              registry_name: @vue_js_component_config[:registry_name],
              component_name: @vue_js_component_config[:component_name]
            )
          end
        end
      end
  
      private
  
      def pin_component(registry_name:,
                        file_path:)
        "pin \"#{registry_name}\", to: \"#{file_path}\"\n"
      end
  
      def pack_file_component_import(component_name:,
                                    component_path:)
        "import #{component_name} from '#{component_path}'\n\n"
      end
  
      def pack_file_component_registration(app_instance_name:,
                                          registry_name:,
                                          component_name:)
        "\n#{app_instance_name}.component('#{registry_name}', #{component_name})"
      end
  
      def app_instance_name(file_path)
        @app_instance_name ||= File.readlines(Rails.root + file_path).find do |l|
                                l.match?(/^const.*createApp/)
                              end.split('=').map(&:strip).first.split(' ').last
      end
  
      def importmap?
        File.exist?('config/importmap.rb')
      end
  
      def webpacker?
        File.exist?('app/javascript/packs/application.js')
      end
  
      def ensure_eof_newline_on(file_path)
        unless File.readlines(file_path).last.end_with?("\n")
          File.open(file_path, 'a') do |file|
            file.puts
          end
        end
      end
    end
  end
  
end
