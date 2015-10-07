module NipPeselRegon
  module Calculator

    # This class is responsible
    # for calculating checksum
    class Checksum
      def initialize(weights, number)
        @weights = weights
        @number = number
      end

      def calculate
        @weights.each_with_index.inject(0) {|sum, (weight, i)| sum + @number[i].to_i * weight}
      end
    end
  end
end