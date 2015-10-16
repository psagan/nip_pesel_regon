module NipPeselRegon
  module Validator

    # Class responsible for 14-digit REGON validation.
    class Regon14 < Base

      # array with weights
      WEIGHTS = [2, 4, 8, 5, 0, 9, 7, 3, 6, 1, 2, 4, 8].freeze

      # pattern for 14-digit REGON
      PATTERN = /^\d{14}$/

      private

      # Main validation method.
      def validate
        # check if REGON with 14 digits is proper
        # REGON with 9 digits by slicing
        # first 9 digits and testing against Regon9
        return false unless is_valid_regon9?

        # check if calculated checksum modulo 11 is equal to last digit of REGON
        # if yes then validation is correct
        (checksum % 11) == number[-1].to_i
      end

      # Method responsible
      # for testing if first 9 digits of 14-digit REGON
      # are proper 9-digits regon (Regon9 class).
      # There is strict dependency here as it's intended to not
      # complicate gem's design.
      def is_valid_regon9?
        Regon9.new(number[0,9]).valid?
      end

    end
  end
end