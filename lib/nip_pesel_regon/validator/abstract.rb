module NipPeselRegon
  module Validator
    class Abstract

      # no method
      NO_METHOD_ERROR_MSG = "No %s method defined in %s"

      attr_reader :number, :original_number, :checksum_calculator

      def initialize(number)
        @number = number
        # keep original number
        @original_number = number
        # normalize provided number
        normalize
        # create instance of checksum calculator
        set_checksum_calculator
      end

      def valid?
        # check if NIP provided has proper format
        return false unless has_proper_format?
        validate
      end

      def to_s
        @number
      end

      private

      # method responsible for detection if number provided has proper format
      def has_proper_format?
        !@number.nil? && matches_pattern?
      end

      # method responsible for pattern matching
      def matches_pattern?
        self.class::PATTERN =~ @number
      end

      def validate
        raise NoMethodError, no_method_error_message('validate')
      end

      # method responsible for sum calculation
      # every digit from first 9 digits of NIP is multiplied with corresponding
      # weight and summed
      def calculate_sum
        checksum_calculator.calculate
      end

      def no_method_error_message(method_name)
        sprintf(NO_METHOD_ERROR_MSG, method_name, self.class)
      end

      def normalize
        @number = @number.to_s.gsub(/[-\s]/, '')
      end

      def set_checksum_calculator
        if defined? self.class::WEIGHTS
          @checksum_calculator = NipPeselRegon::Calculator::Checksum.new(self.class::WEIGHTS, @number)
        end
      end

    end
  end
end