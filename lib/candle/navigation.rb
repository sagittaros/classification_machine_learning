module Candle
  module Navigation
    def prev
      if @index == 0
        nil
      else
        self.class.candles[@index - 1]
      end
    end

    def next
      if @index == self.class.candles.length - 1
        nil
      else
        self.class.candles[@index + 1]
      end
    end
  end
end