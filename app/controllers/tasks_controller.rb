class TasksController < ApplicationController
  before_action :set_task, only: :destroy
  skip_before_filter  :verify_authenticity_token

  def index
    @task = Task.new
    @tasks = Task.all
  end

  def create
    if request.method != "OPTIONS"
      task = Task.new(task_params)
      task.save
    end
      @tasks = Task.all
      render json: @tasks
  end

  def complete
    if request.method != "OPTIONS"
      task = Task.find(JSON.parse(request.body.string)["task_id"])
      task.update_attribute(:completed, !task.completed)
    end
      @tasks = Task.all
      render json: @tasks
  end

  def destroy
    if request.method != "OPTIONS"
      @task.destroy
    end
    @tasks = Task.all
    render json: @tasks
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params["task"] = JSON.parse(request.body.string)
      params.require(:task).permit(:description, :completed)
    end
end
