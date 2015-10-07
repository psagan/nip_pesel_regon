module NipPeselRegon
  module Validator
    class Regon < Abstract

      attr_reader :regon_validator

      def initialize(regon)
        super
        case(@number.length)
          when 9
            @regon_validator = Regon9.new(@number)
          when 14
            @regon_validator = Regon14.new(@number)
        end
      end

      private

      def normalize
        @number = @number.to_s.gsub(/[-\s]/, '')
      end

      def validate
        @regon_validator.validate
      end
    end

    #@todo - move those classes to other files
    class RegonValidatorAbstract
      attr_reader :checksum_calculator

      def initialize(number)
        @number = number
        @checksum_calculator = NipPeselRegon::Calculator::Checksum.new(self.class::WEIGHTS, @number)
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

      def calculate_sum
        checksum_calculator.calculate
      end
    end

    class Regon9 < RegonValidatorAbstract
      WEIGHTS = [8, 9, 2, 3, 4, 5, 6, 7]

      PATTERN = /^\d{9}$/

      def validate
        # check if REGON provided has proper format
        return false unless has_proper_format?

        mod = calculate_sum % 11

        # if mod is equal to 10 then set it to 0
        mod = 0 if mod == 10

        # compare mod with last digit
        mod == @number[-1].to_i
      end

    end

    class Regon14 < RegonValidatorAbstract
      WEIGHTS = [2, 4, 8, 5, 0, 9, 7, 3, 6, 1, 2, 4, 8]

      PATTERN = /^\d{14}$/

      def validate
        # check if REGON provided has proper format
        return false unless has_proper_format?

        # check if REGON with 14 digits is proper
        # REGON with 9 digits by slicing
        # first 9 digits and testing against Regon9
        return false unless is_valid_regon9?

        mod = calculate_sum % 11

        # compare mod with last digit
        mod == @number[-1].to_i
      end

      # method responsible
      # for testing if first 9 digits of 14-digit REGON
      # are proper 9-digits regon (Regon9 class)
      def is_valid_regon9?
         Regon9.new(@number[0,9]).validate
      end

    end
  end
end