require 'active_support/inflector'

module NipPeselRegon
  module Integration

    # Class responsible for simple integration
    # NIP/PESEL/REGON validation into active model validation.
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

      # Method responsible for handling default options
      # and merging them with custom options provided by developer.
      def handle_default_options
        # before mergin check if custom :message provided by developer
        message_provided = options[:message]

        # do merge
        @options = DEFAULT_OPTIONS.merge(options)

        # handle default message template based on condition if
        # custom message was provided by developer
        @options[:message] = options[:message] % options[:validator].upcase unless message_provided
      end

      def validate_each(record, attribute, value)
        # do validation
        validator = "NipPeselRegon::Validator::#{options[:validator].capitalize}".constantize.new(value, options)

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

    # Standard Rails module which will
    # be included into ActiveRecord::Base.
    #
    # Code below is responsible for NIP/PESEL/REGON
    # validation methods creation.
    #
    # In the result subclasses of ActiveRecord::Base will
    # have following methods available:
    # - validates_nip_of
    # - validates_pesel_of
    # - validates_regon_of
    #
    module HelperMethods
      %w{nip pesel regon}.each do |validator_name|
        define_method("validates_#{validator_name}_of") do |*attr_names|
          # extract options to add validator name to them
          options = attr_names.extract_options!
          # add validator name
          options[:validator] = validator_name
          # add options back to attr_names
          attr_names << options
          validates_with NipPeselRegon::Integration::Rails, _merge_attributes(attr_names)
        end
      end
    end

  end
end