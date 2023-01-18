# frozen_string_literal: true

require 'rails/generators/base'
require_relative '../constants'

module Matestack
  class LayoutGenerator < Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)

    argument :name, type: :string
    class_option :base, type: :boolean, default: true, desc: 'Inherit from ApplicationPage'
    class_option :full, type: :boolean, default: false, desc: 'Generate a "fully-featured" page'

    include Constants

    def setup_generator_config
      @layout_config = {}.tap do |config|
        config[:template_file_path] = "layout#{TEMPLATE_FILE_TYPE}"
        config[:file_path] = "#{MATESTACK_DIRECTORY}/#{name.underscore}#{RUBY_FILE_TYPE}"
        config[:klass] = name.split('/').map(&:camelcase).join('::')
        config[:base_klass] = if options[:base] && File.exist?(APPLICATION_LAYOUT_DEFAULT_FILE_PATH)
                                'ApplicationLayout'
                              else
                                'Matestack::Ui::Layout'
                              end
      end
    end

    def generate_matestack_layout
      template @layout_config[:template_file_path], @layout_config[:file_path]
    end
  end
end
