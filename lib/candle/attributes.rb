module Candle
  module Attributes

    def attribute_names
      self.methods.grep(/expl.+/)
    end

    def attributes
      attribute_names.collect {|name| self.send name}
    end

    module SelfAttributes
      def expl_direction
        bull?? 1 : -1
      end

      def expl_upper_wick_length
        if bull?
          @high - @close
        else
          @high - @open
        end
      end

      def expl_lower_wick_length
        if bull?
          @open - @low
        else
          @close - @low
        end
      end

      def expl_wick_length
        expl_upper_wick_length + expl_lower_wick_length
      end

      def expl_body_length
        @close - @open
      end

      def expl_absolute_body_length
        expl_body_length.abs
      end

      def expl_candle_length
        @high - @low
      end

      def expl_dist_10000_pips
        @close.round(-1) - @close
      end

      def expl_dist_1000_pips
        @close.round - @close
      end

      def expl_dist_100_pips
        @close.round(1) - @close
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