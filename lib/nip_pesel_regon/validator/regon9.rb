module NipPeselRegon
  module Validator

    # Class responsible for 9-digit REGON validation.
    class Regon9 < Base

      # array with weights
      WEIGHTS = [8, 9, 2, 3, 4, 5, 6, 7].freeze

      # pattern for 9-digit REGON
      PATTERN = /^\d{9}$/

      private

      # Main validation method.
      def validate
        mod = checksum % 11

        # if mod is equal to 10 then set it to 0
        mod = 0 if mod == 10

        # check if mod is equal to last digit of REGON
        # if yes then validation is correct
        mod == number[-1].to_i
      end

    end
  end
end

