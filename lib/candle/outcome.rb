module Candle
  module Outcome

    def self.included(base)
      base.extend ClassMethods
    end

    # first compare with open, then compare with high/low, if both high/low exceeds PIP_TARGET,
    # get the one with longer distance from current close
    def calculate_outcome
      _outcome = nil # -1 or 1
      compared_candle = self.next
      while _outcome.nil? and !compared_candle.nil? do
        if compared_candle.open - @close > PIP_TARGET
          _outcome = 1
        elsif @close - compared_candle.open > PIP_TARGET
          _outcome = -1
        elsif compared_candle.high - @close > PIP_TARGET and @close - compared_candle.low > PIP_TARGET
          if compared_candle.high - @close > @close - compared_candle.low
            _outcome = 1
          elsif compared_candle.high - @close < @close - compared_candle.low
            _outcome = -1
          else
            _outcome = rand(100).even?? 1 : -1
          end
        end
        compared_candle = compared_candle.next
      end
      _outcome
    end

    module ClassMethods
      def generate_outcomes
        delete_after = nil
        @candles.each do |c|
          c.outcome = c.calculate_outcome
          # truncate those after outcome=nil
          if c.outcome.nil? and delete_after.nil?
            delete_after = c
          end
        end
        @candles = @candles[0..(delete_after.index-1)]
      end
    end

  end
end