# frozen_string_literal: true

require 'rails/generators/base'
require_relative '../constants'

module Matestack
  class VueJsComponentGenerator < Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)

    argument :name, type: :string
    class_option :base, type: :boolean, default: true, desc: 'Inherit from ApplicationVueJsComponent'
    class_option :registry, type: :boolean, default: true, desc: 'Add to the Component Registry'
    class_option :full, type: :boolean, default: false, desc: 'Generate a "fully-featured" component'

    include Constants

    def setup_generator_config
      @ruby_component_config = {}.tap do |config|
        config[:template_file_path] = "ruby_component#{TEMPLATE_FILE_TYPE}"
        config[:file_path] = "#{COMPONENT_DIRECTORY}/#{name.underscore}#{RUBY_FILE_TYPE}"
        config[:klass] = ['Components', name.split('/')].flatten.map(&:camelcase).join('::')
        config[:base_klass] = if options[:base] && File.exist?(APPLICATION_VUE_JS_COMPONENT_DEFAULT_FILE_PATH)
                                'ApplicationVueJsComponent'
                              else
                                'Matestack::Ui::VueJsComponent'
                              end
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
      if File.exist?('config/importmap.rb')
        append_to_file 'config/importmap.rb' do
          "pin \"#{@vue_js_component_config[:registry_name]}\", to: \"#{@vue_js_component_config[:file_path]}\""
        end

        inject_into_file 'app/javascript/packs/application.js', before: /createApp/ do
          <<~JS
            import #{@vue_js_component_config[:component_name]} from '../../../#{@vue_js_component_config[:file_path]}'

          JS
        end

        app_instance_name = File.readlines(Rails.root + 'app/javascript/application.js').find do |l|
          l.match?(/^const.*createApp/)
        end.split('=').map(&:strip).first.split('').last

        inject_into_file 'app/javascript/application.js', after: /^const.*createApp/ do
          <<~JS

            #{app_instance_name}.component('#{@vue_js_component_config[:registry_name]}', #{@vue_js_component_config[:component_name]})
          JS
        end
      end
    end
  end
end
