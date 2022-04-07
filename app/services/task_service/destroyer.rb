# frozen_string_literal: true

module TaskService
  # To destroy task.
  class Destroyer < ApplicationService
    def initialize(task)
      super()
      @task = task
    end

    def call
      @task.destroy
    end
  end
end
