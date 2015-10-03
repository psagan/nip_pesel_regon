module NipPeselRegon
  module Validator
    class Abstract
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
        raise NoMethodError, "No validate method defined in #{self.class}"
      end

      def normalize
        raise NoMethodError, "No normalize method defined in #{self.class}"
      end
    end
  end
end