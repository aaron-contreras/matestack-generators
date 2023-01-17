# frozen_string_literal: true

require 'rails/generators/base'
require_relative '../constants'

module Matestack
  class PageGenerator < Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)

    argument :name, type: :string
    class_option :base, type: :boolean, default: true, desc: 'Inherit from ApplicationPage'
    class_option :full, type: :boolean, default: false, desc: 'Generate a "fully-featured" page'

    include Constants

    def setup_generator_config
      @page_config = {}.tap do |config|
        config[:template_file_path] = "page#{TEMPLATE_FILE_TYPE}"
        config[:file_path] = "#{MATESTACK_DIRECTORY}/#{name.underscore}#{RUBY_FILE_TYPE}"
        config[:klass] = name.split('/').map(&:camelcase).join('::')
        config[:base_klass] = if options[:base] && File.exist?(APPLICATION_PAGE_DEFAULT_FILE_PATH)
                                'ApplicationPage'
                              else
                                'Matestack::Ui::Page'
                              end
      end
    end

    def generate_matestack_page
      debugger
      template @page_config[:template_file_path], @page_config[:file_path]
    end
  end
end
