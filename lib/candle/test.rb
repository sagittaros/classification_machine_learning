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

    def compare_with_svm_model(svm_model)
      p = 0
      u = 0
      v = 0
      q = 0
      @candles.each do |c|
        predicted = svm_model.predict c.attributes
        if predicted == c.outcome
          if predicted == 1
            v += 1
          else
            p += 1
          end
        else
          if predicted == -1
            u += 1
          else
            q += 1
          end
        end
      end
      {
          buy_signals: v+q,
          sell_signals: p+u,
          tp: v.to_f/(u+v).to_f,
          fp: q.to_f/(p+q).to_f,
          tn: p.to_f/(p+q).to_f,
          fn: u.to_f/(u+v).to_f,
          accuracy: (p+v).to_f/(p+v+q+u).to_f,
          buy_precision: v.to_f/(q+v).to_f,
          sell_precision: p.to_f/(p+u).to_f
      }
    end

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
      {
          buy_signals: v+q,
          sell_signals: p+u,
          tp: v.to_f/(u+v).to_f,
          fp: q.to_f/(p+q).to_f,
          tn: p.to_f/(p+q).to_f,
          fn: u.to_f/(u+v).to_f,
          accuracy: (p+v).to_f/(p+v+q+u).to_f,
          buy_precision: v.to_f/(q+v).to_f,
          sell_precision: p.to_f/(p+u).to_f
      }
    end

  end
end