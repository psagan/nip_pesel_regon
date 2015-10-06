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
        raise NoMethodError, sprintf(NO_METHOD_ERROR_MSG, 'validate', self.class)
      end

      def normalize
        raise NoMethodError,sprintf(NO_METHOD_ERROR_MSG, 'normalize', self.class)
      end

    end
  end
end