# frozen_string_literal: true

# Exposes API for interacting with Tasks.
class TasksController < ApplicationController
  before_action :find_project
  before_action :find_task, only: %i[show update destroy]

  def index
    render json: TaskSerializer.new(@project.tasks).serializable_hash
  end

  def create
    result = TaskService::Creator.call(@project, task_params)

    if result.success?
      render json: TaskSerializer.new(result.task).serializable_hash
    else
      render json: { errors: result.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    render json: TaskSerializer.new(@task).serializable_hash
  end

  def update
    result = TaskService::Updater.call(@task, task_params)

    if result.success?
      render json: TaskSerializer.new(result.task).serializable_hash
    else
      render json: { errors: result.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    TaskService::Destroyer.call(@task)
    head :ok
  end

  private

  def find_project
    @project = ProjectService::Finder.call(nil, params[:project_id])
  end

  def find_task
    @task = TaskService::Finder.call(@project, params[:id])
  end

  def task_params
    params.permit(:name, :description)
  end
end
