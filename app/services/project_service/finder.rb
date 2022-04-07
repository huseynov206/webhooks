# frozen_string_literal: true

module ProjectService
  # To find project by ID.
  class Finder < ApplicationService
    def initialize(organization, project_id)
      super()
      @organization = organization
      @project_id = project_id
    end

    def call
      if @organization
        @organization.projects.find(@project_id)
      else
        Project.find(@project_id)
      end
    end
  end
end
