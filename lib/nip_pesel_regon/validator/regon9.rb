module NipPeselRegon
  module Validator
    class Regon9 < Base
      WEIGHTS = [8, 9, 2, 3, 4, 5, 6, 7]

      PATTERN = /^\d{9}$/

      private

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

