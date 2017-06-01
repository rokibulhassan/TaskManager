class TasksController < ApplicationController
  load_and_authorize_resource only: [:show, :update, :destroy]
  before_action :set_task, only: [:show, :update, :destroy]

  def index
    render json: current_user.tasks.as_priority.as_json(:except => [:created_at, :updated_at])
  end

  def create
    task = Task.create!(task_params)
    render json: task, status: 201
  end

  def show
    render json: @task, status: 201
  end

  def update
    @task.update(task_params)
    render nothing: true, status: 204
  end

  def destroy
    @task.destroy
    render nothing: true, status: 204
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:user_id, :title, :description, :due_date, :completed, :priority)
  end
end
