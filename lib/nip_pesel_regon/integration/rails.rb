module NipPeselRegon
  module Integration
      # class responsible for simple integration
      # NIP/PESEL/REGON validation into active model validation
    class Rails < ActiveModel::EachValidator

      # hash with default options
      DEFAULT_OPTIONS = {
          save_normalized: true,
          message: 'invalid %s'
      }

      def initialize(*attr)
        super
        handle_default_options
      end

      # method responsible for merging options provided by developer
      # with default options
      def handle_default_options
        message_provided = options[:message]
        @options = DEFAULT_OPTIONS.merge(options)

        # handle message
        @options[:message] = options[:message] % options[:validator].upcase unless message_provided
      end


      def validate_each(record, attribute, value)
        # do validation
        validator = self.class.const_get("NipPeselRegon::Validator::#{options[:validator].capitalize}").new(value, options)

        if validator.valid?
          # if NIP/PESEL/REGON is valid and 'save_normalized' options is set to true
          # then assign normalized value to attribute otherwise it will be
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

module ActiveModel
  module Validations
    module HelperMethods
      %w{nip pesel regon}.each do |validator_name|
        define_method("validates_#{validator_name}_of") do |*attr_names|
          options = attr_names.extract_options!
          options[:validator] = validator_name
          attr_names << options
          validates_with NipPeselRegon::Integration::Rails, _merge_attributes(attr_names)
        end
      end
    end
  end
end