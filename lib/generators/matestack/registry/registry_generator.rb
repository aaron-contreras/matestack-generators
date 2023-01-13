# frozen_string_literal: true

require 'rails/generators/base'
require_relative '../constants'

module Matestack
  class RegistryGenerator < Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)

    include Constants

    REGISTRY_DIRECTORY = 'components'
    REGISTRY_FILE_NAME = 'registry'
    APPLICATION_LAYOUT_FILE_NAME = 'application_layout'
    APPLICATION_PAGE_FILE_NAME = 'application_page'
    APPLICATION_COMPONENT_FILE_NAME = 'application_component'
    APPLICATION_VUE_JS_COMPONENT_FILE_NAME = 'application_vue_js_component'

    def build_class_names
      @registry_class_name = [REGISTRY_DIRECTORY.camelcase, REGISTRY_FILE_NAME.camelcase].join('::')
      @application_layout_class_name = APPLICATION_LAYOUT_FILE_NAME.camelcase
      @application_page_class_name = APPLICATION_PAGE_FILE_NAME.camelcase
      @application_component_class_name = APPLICATION_COMPONENT_FILE_NAME.camelcase
      @application_vue_jscomponent_class_name = APPLICATION_VUE_JS_COMPONENT_FILE_NAME.camelcase
    end

    def generate_registry
      template "#{REGISTRY_FILE_NAME}.rb.erb", "#{MATESTACK_DIRECTORY}/#{REGISTRY_DIRECTORY}/#{REGISTRY_FILE_NAME}.rb"
    end

    def generate_application_layout
      template "#{APPLICATION_LAYOUT_FILE_NAME}.rb.erb", "#{MATESTACK_DIRECTORY}/#{APPLICATION_LAYOUT_FILE_NAME}.rb"
    end

    def generate_application_layout
      template "#{APPLICATION_LAYOUT_FILE_NAME}.rb.erb", "#{MATESTACK_DIRECTORY}/#{APPLICATION_LAYOUT_FILE_NAME}.rb"
    end

    def generate_application_component
      template "#{APPLICATION_COMPONENT_FILE_NAME}.rb.erb", "#{MATESTACK_DIRECTORY}/#{APPLICATION_COMPONENT_FILE_NAME}.rb"
    end

    def generate_application_vue_js_component
      template "#{APPLICATION_VUE_JS_COMPONENT_FILE_NAME}.rb.erb", "#{MATESTACK_DIRECTORY}/#{APPLICATION_VUE_JS_COMPONENT_FILE_NAME}.rb"
    end
  end
end
