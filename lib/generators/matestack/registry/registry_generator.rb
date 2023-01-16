# frozen_string_literal: true

require 'rails/generators/base'

require_relative '../constants'

module Matestack
  class RegistryGenerator < Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)

    class_option :core, type: :boolean, default: false,
                        desc: 'Include matestack-ui-core base classes to share the component registry'
    class_option :vue_js, type: :boolean, default: false,
                          desc: 'Include matestack-ui-vue-js base classes to share the component registry'

    include Constants

    def build_class_names
      @registry_config = {}.tap do |config|
        config[:template_file_path] = "#{REGISTRY_IDENTIFIER}#{TEMPLATE_FILE_TYPE}"
        config[:file_path] = "#{MATESTACK_DIRECTORY}/#{REGISTRY_DIRECTORY}/#{REGISTRY_IDENTIFIER}#{RUBY_FILE_TYPE}"
        config[:klass] = [REGISTRY_DIRECTORY, REGISTRY_IDENTIFIER].map(&:to_s).map(&:camelcase).join('::')
      end

      if options[:core]
        @core_config = {}.tap do |config|
          CORE_IDENTIFIERS.each do |identifier|
            config[identifier] = {
              template_file_path: "#{identifier}#{TEMPLATE_FILE_TYPE}",
              file_path: "#{MATESTACK_DIRECTORY}/#{identifier}#{RUBY_FILE_TYPE}",
              klass: identifier.to_s.camelcase
            }
          end
        end
      end

      if options[:vue_js]
        @vue_js_config = {}.tap do |config|
          VUE_JS_IDENTIFIERS.each do |identifier|
            config[identifier] = {
              template_file_path: "#{identifier}#{TEMPLATE_FILE_TYPE}",
              file_path: "#{MATESTACK_DIRECTORY}/#{identifier}#{RUBY_FILE_TYPE}",
              klass: identifier.to_s.camelcase
            }
          end
        end
      end
    end

    def generate_registry
      template @registry_config[:template_file_path], @registry_config[:file_path]
    end

    def generate_core_base_classes
      if options[:core]
        @core_config.each do |_identifier, config|
          template config.dig(:template_file_path), config.dig(:file_path)
        end
      end
    end

    def generate_vue_js_base_classes
      if options[:vue_js]
        @vue_js_config.each do |_identifier, config|
          template config.dig(:template_file_path), config.dig(:file_path)
        end
      end
    end
  end
end
