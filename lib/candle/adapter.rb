module Candle
  module Adapter
    def attribute_matrix
      attribute_matrix = []
      @candles.each do |c|
        attribute_matrix << c.attributes
      end
      attribute_matrix
    end

    def outcomes
      outcomes = []
      @candles.each do |c|
        outcomes << c.outcome
      end
      outcomes
    end
  end
end