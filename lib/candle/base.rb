module Candle
  class Base
    include Candle::Navigation
    include Candle::Attributes

    attr_reader :index, :open, :high, :low, :close, :volume
    @candles = []

    RANGE = 40 * 0.01

    def initialize(index, open, high, low, close, volume)
      @index = index
      @open = open.to_f
      @high = high.to_f
      @low = low.to_f
      @close = close.to_f
      @volume = volume.to_f
      self.class.candles << self
    end

    class << self
      attr_reader :candles

      def reset
        @candles = []
      end
    end

  end
end