module NipPeselRegon
  module Validator
    class Abstract

      # no method
      NO_METHOD_ERROR_MSG = "No %s method defined in %s"

      attr_reader :number, :original_number

      def initialize(number)
        @number = number
        # keep original number
        @original_number = number
        # normalize provided number
        normalize
      end

      def valid?
        validate
      end

      def to_s
        @number
      end

      private

      def validate
        raise NoMethodError, no_method_error_message('validate')
      end

      def normalize
        raise NoMethodError, no_method_error_message('normalize')
      end

      def no_method_error_message(method_name)
        sprintf(NO_METHOD_ERROR_MSG, method_name, self.class)
      end

    end
  end
end