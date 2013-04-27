module Candle

  class Base
    include Candle::Navigation
    include Candle::Attributes
    include Candle::Features
    include Candle::Outcome
    extend Candle::Test
    extend Candle::Statistics
    extend Candle::Adapter

    attr_reader :index, :open, :high, :low, :close, :volume
    attr_accessor :outcome
    @candles = []
    @pips_target = 100 * 0.01

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
      attr_reader :candles, :pips_target

      def reset
        @candles = []
      end

      def set_pips_target(pips, point)
        @pips_target = pips * point
      end
    end

  end
end