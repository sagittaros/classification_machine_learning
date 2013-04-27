require_relative 'boot'

EURJPY240 = File.join DATA_PATH, 'EURJPY', 'EURJPY240.csv'
price_data = CSV.read EURJPY240
training_data = price_data[0..14999]
test_data = price_data[15000..-1]

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
p lp.get_model


