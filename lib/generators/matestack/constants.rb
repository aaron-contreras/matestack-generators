module Matestack
  module Constants
    # Filesystem paths
    MATESTACK_DIRECTORY = 'app/matestack'
    REGISTRY_DIRECTORY = 'components'
    BASE_CLASS_DIRECTORY = './'
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
