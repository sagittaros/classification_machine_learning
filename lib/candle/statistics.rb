module Candle
  module Statistics

    def mean_for(metric)
      if Candle::Base.instance_methods.include? metric
        vector = @candles.collect {|candle| candle.send metric}.to_scale
        vector.mean
      else
        raise "Metric #{metric} is not defined"
      end
    end

    def sd_for(metric)
      if Candle::Base.instance_methods.include? metric
        vector = @candles.collect {|candle| candle.send metric}.to_scale
        vector.sd
      else
        raise "Metric #{metric} is not defined"
      end
    end

    def draw_histogram_for(metric)
      if Candle::Base.instance_methods.include? metric
        vector = @candles.collect {|candle| candle.send metric}.to_scale
        rb=ReportBuilder.new
        rb.add(Statsample::Graph::Histogram.new(vector))
        rb.save_html(File.join(GRAPH_PATH, "#{metric}-histogram.html"))
      else
        raise "Metric #{metric} is not defined"
      end
    end
  end
end