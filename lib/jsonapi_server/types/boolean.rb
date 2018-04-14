# frozen_string_literal: true

module JSONAPI
  class Server
    module Types
      class Boolean < Type
        FALSE_VALUES = [false, 0, '0', 'f', 'F', 'false', 'FALSE', 'off', 'OFF'].to_set
        TRUE_VALUES = [true, 1, '1', 't', 'T', 'true', 'TRUE', 'on', 'ON'].to_set

        def deserialize(value)
          return nil if value.nil? || value == ''

          is_false = FALSE_VALUES.include?(value)
          return false if is_false

          is_true = TRUE_VALUES.include?(value)
          return true if is_true

          invalid_value_type(value)
        end
      end
    end
  end
end
