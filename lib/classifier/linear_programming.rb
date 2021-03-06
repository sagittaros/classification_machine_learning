module Classifier
  class LinearProgramming

    def initialize(feature_matrix, outcomes)
      @problem = Rglpk::Problem.new
      @problem.name = 'Classification using Linear Programming'
      @problem.obj.dir = Rglpk::GLP_MIN
      @feature_matrix = feature_matrix
      @num_of_features = @feature_matrix.first.length
      @outcomes = outcomes
      @model = []
    end

    ## @rows[index].set_bounds(Rglpk::GLP_LO, 1, 1) because our `c`, the separator, is 1
    def configure_rows
      @rows = @problem.add_rows @feature_matrix.length
      @outcomes.each_with_index do |outcome, index|
        @rows[index].name = index.to_s
        if outcome > 0
          @rows[index].set_bounds(Rglpk::GLP_LO, 1, 1)
        else
          @rows[index].set_bounds(Rglpk::GLP_UP, 1, 1)
        end
      end
    end

    def configure_cols
      @cols = @problem.add_cols @num_of_features + 1
      @num_of_features.times do |i|
        @cols[i].name = i.to_s
        @cols[i].set_bounds(Rglpk::GLP_FR, 0.0, 0.0)
      end
      @cols[@num_of_features].name = 'Grey Zone'
      @cols[@num_of_features].set_bounds(Rglpk::GLP_LO, 0.0, 0.0)
    end

    def fill_data
      data_matrix = []
      @feature_matrix.each_with_index do |line, index|
        data_matrix << (line << @outcomes[index])
      end
      data_matrix.flatten!
      @problem.set_matrix data_matrix
    end

    def run
      configure_rows
      configure_cols
      @problem.obj.coefs = [0] * @num_of_features << 1
      fill_data
      @problem.simplex
      @num_of_features.times do |i|
        @model[i] = @cols[i].get_prim
      end
    end

    def get_model
      @model
    end

    def get_objective
      @problem.obj.get
    end

  end
end