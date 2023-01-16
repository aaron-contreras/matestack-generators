# frozen_string_literal: true

require 'rails/generators/base'
require_relative '../constants'

module Matestack
  class ComponentGenerator < Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)

    argument :name, type: :string
    class_option :base, type: :boolean, default: true, desc: 'Inherit from ApplicationComponent'
    class_option :registry, type: :boolean, default: true, desc: 'Add to the Component Registry'
    class_option :full, type: :boolean, default: false, desc: '7'

    include Constants

    def setup_generator_config
      @component_config = {}.tap do |config|
        config[:template_file_path] = "component#{TEMPLATE_FILE_TYPE}"
        config[:file_path] = "#{COMPONENT_DIRECTORY}/#{name.underscore}#{RUBY_FILE_TYPE}"
        config[:klass] = ['Components', name.split('/')].flatten.map(&:camelcase).join('::')
        config[:base_klass] = if options[:base] && File.exist?(APPLICATION_COMPONENT_DEFAULT_FILE_PATH)
                                'ApplicationComponent'
                              else
                                'Matestack::Ui::Component'
                              end
        config[:helper_name] = name.split('/').map(&:underscore).join('_') if options[:registry]
      end
    end

    def generate_matestack_component
      template @component_config[:template_file_path], @component_config[:file_path]
    end

    def add_to_registry
      if options[:registry] && File.exist?(REGISTRY_DEFAULT_FILE_PATH)
        inject_into_file 'app/matestack/components/registry.rb', after: "module Components::Registry\n" do
          <<-RUBY.gsub(/^ {12}/, '')
              def #{@component_config[:helper_name]}(text=nil, options=nil, &block)
                #{@component_config[:klass]}.call(text, options, &block)
              end
          RUBY
        end
      end
    end
  end
end
