# frozen_string_literal: true

# Exposes API for interacting with Projects.
class ProjectsController < ApplicationController
  before_action :find_organization
  before_action :find_project, only: %i[show update destroy]

  def index
    render json: ProjectSerializer.new(@organization.projects).serializable_hash
  end

  def create
    result = ProjectService::Creator.call(@organization, project_params)

    if result.success?
      render json: ProjectSerializer.new(result.project).serializable_hash
    else
      render json: { errors: result.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    render json: ProjectSerializer.new(@project).serializable_hash
  end

  def update
    result = ProjectService::Updater.call(@project, project_params)

    if result.success?
      render json: ProjectSerializer.new(result.project).serializable_hash
    else
      render json: { errors: result.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    ProjectService::Destroyer.call(@project)
    head :ok
  end

  private

  def find_organization
    @organization = OrganizationFinder.call(params[:organization_id])
  end

  def find_project
    @project = ProjectService::Finder.call(@organization, params[:id])
  end

  def project_params
    params.permit(:name)
  end
end
