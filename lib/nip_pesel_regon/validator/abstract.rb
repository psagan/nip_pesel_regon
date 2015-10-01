module NipPeselRegon
  module Validator
    class Abstract

      def initialize(num)
        @num = num
      end

      def valid?
        validate
      end

      private

      def validate
        raise NoMethodError, "No validate method defined in #{self.class}"
      end

    end
  end
end