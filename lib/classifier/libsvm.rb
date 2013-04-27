module Classifier
  class Libsvm

    def initialize(attributes, outcomes, params={})
      @problem = Problem.new(
          outcomes,
          attributes
      )
      @parameter = Parameter.new params
      @model = Model.new(@problem,@parameter)
    end

    # @model.predict(data)
    def get_model
      @model
    end

  end
end