module Candle
  module Statistics
    def mean_for(metric)
      sum = @candles.reduce(0) do |sum, candle|
        sum + candle.send(metric)
      end
      sum / @candles.length
    end

    def standard_deviation_for(metric)

    end
  end
end