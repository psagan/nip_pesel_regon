module NipPeselRegon
  module Integration
    module Rails
      class Nip < ActiveModel::EachValidator

        # error message
        ERROR_MESSAGE = 'invalid NIP'

        def validate_each(record, attribute, value)
          validator = NipPeselRegon::Validator::Nip.new(value)
          unless validator.valid?
            record.errors[attribute] << (options[:message] || ERROR_MESSAGE)
          end
        end

      end
    end
  end
end

# add helper method to active model
module ActiveModel
  module Validations
    module HelperMethods

      def validates_nip_of(*attr_names)
        validates_with NipPeselRegon::Integration::Rails::Nip, _merge_attributes(attr_names)
      end

    end
  end
end