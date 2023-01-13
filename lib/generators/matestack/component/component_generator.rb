# frozen_string_literal: true

require 'rails/generators/base'
require_relative '../constants'

module Matestack
  class ComponentGenerator < Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)
    argument :name, type: :string
    class_option :registry, type: :boolean, default: false, desc: "Add to registry on app/matestack/registry.rb"

    include Constants

    COMPONENT_FILE_DIRECTORY = 'components'
    COMPONENT_BASE_PATH = "#{MATESTACK_DIRECTORY}/#{COMPONENT_FILE_DIRECTORY}"
    COMPONENT_BASE_CLASS_NAMESPACE = COMPONENT_FILE_DIRECTORY.split('/')
                                                        .map(&:camelize)
                                                        .join('::')
    
    def generate_component_class_name
      file_name = name.split('/').map(&:camelize).join('::')
      @component_class_name = "#{COMPONENT_BASE_CLASS_NAMESPACE}::#{file_name}"
    end

    def generate_matestack_component
      file_path = "#{COMPONENT_BASE_PATH}/#{name.underscore}"
      template 'component.rb.erb', "#{file_path}.rb"
    end
  end
end
