module NipPeselRegon
  module Integration
    module Rails
      # class responsible for simple integration
      # NIP validation into active model validation
      class Nip < ActiveModel::EachValidator

        # hash with default options
        DEFAULT_OPTIONS = {
            save_normalized: true,
            message: 'invalid NIP'
        }

        # method responsible for merging options provided by developer
        # with default options
        def options
          @options = DEFAULT_OPTIONS.merge(super)
        end

        def validate_each(record, attribute, value)
          # do validation
          validator = NipPeselRegon::Validator::Nip.new(value)

          if validator.valid?
            # if NIP is valid and 'save_normalized' options is set to true
            # then assign normalized NIP to attribute otherwise NIP will be
            # saved as provided by user (without normalization)
            record.send(attribute.to_s + '=', validator.to_s) if options[:save_normalized]
          else
            # add errors message to record's attribute
            record.errors[attribute] << options[:message]
          end
        end

      end
    end
  end
end

module ActiveModel
  module Validations
    module HelperMethods

      # add helper method to active model
      # in the result active models will have
      # new validation method 'validates_nip_of'
      def validates_nip_of(*attr_names)
        validates_with NipPeselRegon::Integration::Rails::Nip, _merge_attributes(attr_names)
      end

    end
  end
end