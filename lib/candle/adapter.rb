module Candle
  module Adapter
    def feature_matrix
      feature_matrix = []
      @candles.each do |c|
        feature_matrix << c.features
      end
      feature_matrix
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