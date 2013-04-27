require_relative 'boot'

class App
  def initialize(pair, period, training_range, test_range)
    @pair = pair
    @period = period
    @training_range = training_range
    @test_range = test_range
  end

  def read_data
    datafile = File.join DATA_PATH, @pair, "#{@pair}#{@period}.csv"
    @price_data = CSV.read datafile
    @training_data = @price_data[@training_range]
    @test_data = @price_data[@test_range]

    p "#{@price_data.length} rows of price data"
    p "#{@training_data.length} rows of training data"
    p "#{@test_data.length} rows of test data"
  end

  def load_candles(type=nil)
    case type
      when :training
        @data = @training_data
      when :test
        @data = @test_data
      else
        @data = @training_data
    end
    Candle::Base.reset
    @data.each_with_index do |row, index|
      Candle::Base.new index, row[2], row[3], row[4], row[5], row[6]
    end
    Candle::Base.generate_outcomes   # generate buy/sell outcomes based on historical data
  end

  def run_svm(kernel_type, c)
    load_candles
    svm = Classifier::Libsvm.new(
        Candle::Base.feature_matrix,
        Candle::Base.outcomes,
        {kernel_type: kernel_type, C: c}
    )
    load_candles :test
    p 'Result for LibSVM:'
    p Candle::Base.compare_with_svm_model(svm.get_model)
  end

  def run_linear_programming
    load_candles
    lp = Classifier::LinearProgramming.new(
        Candle::Base.feature_matrix,
        Candle::Base.outcomes
    )
    lp.run
    lp_model = lp.get_model
    p "LP Model: #{lp_model}"
    p "Objective(a): #{lp.get_objective}"
    load_candles :test
    p 'Result for Linear Programming Method:'
    p Candle::Base.compare_with_lp_model(lp_model)
  end
end

Candle::Base.set_pips_target 100, 0.01
app = App.new('EURJPY', '60', -5700..-1001, -1000..-1)
app.read_data
app.run_linear_programming
app.run_svm(RBF, 1)



