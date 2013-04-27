module Candle
  module Attributes

    module SelfAttributes

      def upper_wick_length
        if bull?
          @high - @close
        else
          @high - @open
        end
      end

      def lower_wick_length
        if bull?
          @open - @low
        else
          @close - @low
        end
      end

      def wick_length
        upper_wick_length + lower_wick_length
      end

      def body_length
        @close - @open
      end

      def absolute_body_length
        body_length.abs
      end

      def candle_length
        @high - @low
      end

      def bull?
        @close > @open
      end

      def bear?
        @close < @open
      end
    end

    include SelfAttributes
  end
end