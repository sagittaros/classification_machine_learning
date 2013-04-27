module Candle

  PIP_TARGET = 150 * 0.01 # 100 pips

  class Base
    include Candle::Navigation
    include Candle::Attributes
    include Candle::Outcome
    extend Candle::Test
    extend Candle::Statistics
    extend Candle::Adapter

    attr_reader :index, :open, :high, :low, :close, :volume
    attr_accessor :outcome
    @candles = []

    def initialize(index, open, high, low, close, volume)
      @index = index # first index should be 0
      @open = open.to_f
      @high = high.to_f
      @low = low.to_f
      @close = close.to_f
      @volume = volume.to_i
      @outcome = nil
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