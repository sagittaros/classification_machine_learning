module Candle
  module Attributes

    module SelfAttributes
      def direction
        bull?? 1 : -1
      end

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
        body.abs
      end

      def candle_length
        @high - @low
      end

      def distance_to_special_numbers

      end

      def dist_10000_pips
        @close.round(-1) - @close
      end

      def dist_1000_pips
        @close.round - @close
      end

      def dist_100_pips
        @close.round(1) - @close
      end

      protected

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