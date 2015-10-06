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
        (0...(@weights.length)).inject(0) {|sum, i| sum += @number[i].to_i * @weights[i]}
      end
    end
  end
end