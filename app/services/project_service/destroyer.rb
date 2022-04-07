# frozen_string_literal: true

module ProjectService
  # To destroy project.
  class Destroyer < ApplicationService
    def initialize(project)
      super()
      @project = project
    end

    def call
      @project.destroy
    end
  end
end
