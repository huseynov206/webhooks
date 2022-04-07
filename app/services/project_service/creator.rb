# frozen_string_literal: true

module ProjectService
  # To create project.
  class Creator < ApplicationService
    def initialize(organization, project_params)
      super()
      @organization = organization
      @project_params = project_params
    end

    def call
      project = @organization.projects.create(@project_params)

      if project.save
        OpenStruct.new(success?: true, project: project, errors: nil)
      else
        OpenStruct.new(success?: false, project: nil, errors: project.errors)
      end
    end
  end
end
