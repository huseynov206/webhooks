# frozen_string_literal: true

module TaskService
  # To update task.
  class Updater < ApplicationService
    def initialize(task, task_params)
      super()
      @task = task
      @task_params = task_params
    end

    def call
      if @task.update(@task_params)
        OpenStruct.new(success?: true, task: @task, errors: nil)
      else
        OpenStruct.new(success?: false, task: nil, errors: @task.errors)
      end
    end
  end
end
