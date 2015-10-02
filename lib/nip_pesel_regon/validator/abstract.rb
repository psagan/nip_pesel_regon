module NipPeselRegon
  module Validator
    class Abstract
      attr_reader :num, :original_number

      def initialize(num)
        @num = num
        @original_number = @num
        # normalize provided number
        normalize
      end

      def valid?
        validate
      end

      def to_s
        @num
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