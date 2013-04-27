module Candle
  module Features
    module Getter
      def feature_names
        self.methods.grep(/expl.+/)
      end

      def features
        feature_names.collect {|name| self.send name}
      end
    end

    def expl_direction
      bull?? 1 : -1
    end

    def expl_dist_1000_pips
      @close.round(-1) - @close
    end

    def expl_dist_100_pips
      @close.round - @close
    end

    def expl_dist_10_pips
      @close.round(1) - @close
    end

    include Getter
  end
end