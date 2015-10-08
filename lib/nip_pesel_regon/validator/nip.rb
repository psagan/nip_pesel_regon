module NipPeselRegon
  module Validator

    # class responsible
    # for nip validation (including standard normalization)
    # please not only polish NIP's are valid with or without 'PL' prefix
    # NIP's with other prefixes like eg. 'DE', 'EN' are invalid
    class Nip < Abstract
      # array with weights
      WEIGHTS = [6, 5, 7, 2, 3, 4, 5, 6, 7] # @todo - candidate for sumcalculator object resonsible only for calculating sum

      # pattern for NIP
      PATTERN = /^\d{10}$/

      private

      # main validation method
      def validate
        # check if calculated sum modulo 11 is equal to last digit from NIP
        # if yes then validation is correct
        (calculate_sum % 11) == number[-1].to_i
      end

      # method responsible for
      # input number normalization before validation
      # 1. Makes input a string
      # 2. Removes all '-' and whitespaces
      # 3. remove 'PL' substring from the beginning if any
      def normalize
        @number = super.gsub(/^PL/i, '') # only pl NIP's are valid
      end

    end
  end
end