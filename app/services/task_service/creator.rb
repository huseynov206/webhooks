# frozen_string_literal: true

module TaskService
  # To create task.
  class Creator < ApplicationService
    def initialize(project, task_params)
      super()
      @project = project
      @task_params = task_params
    end

    def call
      task = @project.tasks.create(@task_params)

      if task.save
        OpenStruct.new(success?: true, task: task, errors: nil)
      else
        OpenStruct.new(success?: false, task: nil, errors: task.errors)
      end
    end
  end
end
