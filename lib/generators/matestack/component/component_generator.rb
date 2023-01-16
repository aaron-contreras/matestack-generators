# frozen_string_literal: true

require 'rails/generators/base'
require_relative '../constants'

module Matestack
  class ComponentGenerator < Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)
    argument :name, type: :string
    class_option :registry, type: :boolean, default: true, desc: 'Add to the default component registry'
    class_option :application_component, type: :boolean, default: true, desc: 'Inherit from ApplicationComponent'

    include Constants

    COMPONENT_FILE_DIRECTORY = 'components'
    COMPONENT_BASE_PATH = "#{MATESTACK_DIRECTORY}/#{COMPONENT_FILE_DIRECTORY}"
    COMPONENT_BASE_CLASS_NAMESPACE = COMPONENT_FILE_DIRECTORY.split('/')
                                                             .map(&:camelize)
                                                             .join('::')

    def generate_class_name
      file_name = name.split('/').map(&:camelize).join('::')
      @component_class_name = "#{COMPONENT_BASE_CLASS_NAMESPACE}::#{file_name}"
    end

    def generate_base_class_name
      @component_base_class_name = if options[:application_component]
                                     'ApplicationComponent'
                                   else
                                     'Matestack::Ui::Component'
                                   end
    end

    def generate_matestack_component
      file_path = "#{COMPONENT_BASE_PATH}/#{name.underscore}"
      template 'component.rb.erb', "#{file_path}.rb"
    end

    def add_to_registry
      if options[:registry]
        if File.exist?('app/matestack/components/registry.rb')
          inject_into_file 'app/matestack/components/registry.rb', after: "module Components::Registry\n" do
            <<-RUBY.gsub(/^ {12}/, '')
              def #{name.split('/').map(&:underscore).join('_')}(text=nil, options=nil, &block)
                #{@component_class_name}.call(text, options, &block)
              end
            RUBY
          end
        end
      end
    end
  end
end
