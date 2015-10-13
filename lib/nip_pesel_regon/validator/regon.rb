module NipPeselRegon
  module Validator

    # Extends Abstract to meet common, public interface
    class Regon < Base

      attr_reader :regon_validator

      def initialize(*attr)
        super
        case(number.length) # number is after normalization
          when 9
            @regon_validator = Regon9.new(number)
          when 14
            @regon_validator = Regon14.new(number)
          else
            @regon_validator = NotValid.new # Null Object Pattern
        end
      end

      def valid?
        regon_validator.valid?
      end

    end

  end
end