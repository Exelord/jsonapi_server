# frozen_string_literal: true

require_relative 'jsonapi_server/engine'

require_relative 'jsonapi_server/exceptions'

# Types
require_relative 'jsonapi_server/types/type'
require_relative 'jsonapi_server/types/string'
require_relative 'jsonapi_server/types/boolean'
require_relative 'jsonapi_server/types/integer'
require_relative 'jsonapi_server/types/float'
require_relative 'jsonapi_server/types/date'
require_relative 'jsonapi_server/types/date_time'
require_relative 'jsonapi_server/types/array'
require_relative 'jsonapi_server/types/hash'

# Data transformers
require_relative 'jsonapi_server/serializer'
require_relative 'jsonapi_server/deserializer'

# Resources
require_relative 'jsonapi_server/attributes'
require_relative 'jsonapi_server/relationships'
require_relative 'jsonapi_server/resource'
require_relative 'jsonapi_server/resources'

require_relative 'jsonapi_server/server'
