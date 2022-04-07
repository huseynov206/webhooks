# frozen_string_literal: true

module ProjectService
  # To update project.
  class Updater < ApplicationService
    def initialize(project, project_params)
      super()
      @project = project
      @project_params = project_params
    end

    def call
      if @project.update(@project_params)
        OpenStruct.new(success?: true, project: @project, errors: nil)
      else
        OpenStruct.new(success?: false, project: nil, errors: @project.errors)
      end
    end
  end
end
