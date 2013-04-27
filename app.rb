require_relative 'boot'


=begin
EURJPY240 = File.join DATA_PATH, 'EURJPY', 'EURJPY5.csv'
price_data = CSV.read EURJPY240
training_data = price_data[930000..-1751]
test_data = price_data[-1750..-1]

p "#{price_data.length} rows of price data"
p "#{training_data.length} rows of training data"
p "#{test_data.length} rows of test data"


training_data.each_with_index do |row, index|
  Candle::Base.new index, row[2], row[3], row[4], row[5], row[6]
end

## generate buy/sell outcomes based on historical data
Candle::Base.generate_outcomes

## Linear Programming
lp = Classifier::LinearProgramming.new(
    Candle::Base.attribute_matrix,
    Candle::Base.outcomes
)

lp.run
lp_model = lp.get_model

p lp_model
p lp.get_objective

## now test the accuracy using test data,
## to do this, first reset candles

Candle::Base.reset
test_data.each_with_index do |row, index|
  Candle::Base.new index, row[2], row[3], row[4], row[5], row[6]
end
Candle::Base.generate_outcomes

p Candle::Base.compare_with_lp_model(lp_model)
=end




