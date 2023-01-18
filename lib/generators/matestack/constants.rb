module Matestack
  module Constants
    # Filesystem paths
    MATESTACK_DIRECTORY = 'app/matestack'
    REGISTRY_DIRECTORY = 'components'
    BASE_CLASS_DIRECTORY = './'
    COMPONENT_DIRECTORY = "#{MATESTACK_DIRECTORY}/components"

    REGISTRY_DEFAULT_FILE_PATH = "#{COMPONENT_DIRECTORY}/registry.rb"
    APPLICATION_COMPONENT_DEFAULT_FILE_PATH = "#{MATESTACK_DIRECTORY}/application_component.rb"
    APPLICATION_PAGE_DEFAULT_FILE_PATH = "#{MATESTACK_DIRECTORY}/application_page.rb"
    APPLICATION_LAYOUT_DEFAULT_FILE_PATH = "#{MATESTACK_DIRECTORY}/application_layout.rb"
    APPLICATION_VUE_JS_COMPONENT_DEFAULT_FILE_PATH = COMPONENT_DIRECTORY

    TEMPLATE_FILE_TYPE = '.rb.erb'
    VUE_JS_TEMPLATE_FILE_TYPE = '.js.erb'

    RUBY_FILE_TYPE = '.rb'
    JAVASCRIPT_FILE_TYPE = '.js'

    REGISTRY_IDENTIFIER = :registry

    CORE_IDENTIFIERS = %i[
      application_layout
      application_page
      application_component
    ]
    VUE_JS_IDENTIFIERS = [
      :application_vue_js_component
    ]
  end
end
