# frozen_string_literal: true

module TaskService
  # To find task with ID.
  class Finder < ApplicationService
    def initialize(project, task_id)
      super()
      @project = project
      @task_id = task_id
    end

    def call
      @project.tasks.find(@task_id)
    end
  end
end
