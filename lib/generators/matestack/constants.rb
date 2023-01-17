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


    TEMPLATE_FILE_TYPE = '.rb.erb'
    RUBY_FILE_TYPE = '.rb'

    REGISTRY_IDENTIFIER = :registry

    CORE_IDENTIFIERS = [
      :application_layout,
      :application_page,
      :application_component,
    ]
    VUE_JS_IDENTIFIERS = [
      :application_vue_js_component
    ]
  end
end
