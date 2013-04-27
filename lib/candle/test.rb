module Candle
  module Test

    # remember `c` is set at 1
    # so if sum of model > 1, it is a buy signal, if sum of model < 1, it is a sell signal
    #
    # Confusion matrix
    #   prediction_negative & actual_negative: p
    #   prediction_negative & actual_positive: u
    #   prediction_positive & actual_positive: v
    #   prediction_positive & actual_negative: q
    #
    # precision = predicted positive cases that are correct = v/(q+v)
    # recall = sensitivity = tp = v/(u+v)
    # fp = q/(p+q)
    # tn = p/(p+q)
    # fn = u/(u+v)
    # accuracy = p+v/p+q+u+v
    #
    def compare_with_lp_model(lp_model)
      p = 0
      u = 0
      v = 0
      q = 0
      gg = 0
      @candles.each do |c|
        sum = 0
        c.attributes.each_with_index do |attr, index|
          sum += attr * lp_model[index]
        end
        if sum > 1
          if c.outcome == 1
            v += 1
          else
            q += 1
          end
        elsif sum < 1
          if c.outcome == -1
            p += 1
          else
            u += 1
          end
        else
          gg += 1
        end
      end
      (p+v).to_f/(p+v+q+u+gg).to_f
    end

  end
end