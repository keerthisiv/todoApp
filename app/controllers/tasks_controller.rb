class TasksController < ApplicationController
  before_action :set_task, only: [:destroy, :update]
  skip_before_filter  :verify_authenticity_token

  def index
    @tasks = Task.all
    render json: @tasks
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

  def toggle_all
    if request.method != "OPTIONS"
      Task.update_all(completed: !JSON.parse(request.body.string)["toggle"])
    end
    @tasks = Task.all
    render json: @tasks
  end

  def update
    if request.method != "OPTIONS"
      @task.update_attribute(:description, JSON.parse(request.body.string)["description"])
    end
    @tasks = Task.all
    render json: @tasks
  end

  def clear_completed
    if request.method != "OPTIONS"
      completed_tasks = Task.where(completed: true)
      completed_tasks.destroy_all
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
