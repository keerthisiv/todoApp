class TasksController < ApplicationController
  before_action :set_task, only: [:destroy, :update]
  skip_before_filter  :verify_authenticity_token

  def index
    render_all_tasks
  end

  def create
    return render_all_tasks if options_request?
    task = Task.new(task_params)
    task.save
    render_all_tasks
  end

  def complete
    return render_all_tasks if options_request?
    task = Task.find(JSON.parse(request.body.string)["task_id"])
    task.update_attribute(:completed, !task.completed)
    render_all_tasks
  end

  def toggle_all
    return render_all_tasks if options_request?
    Task.update_all(completed: !JSON.parse(request.body.string)["toggle"])
    render_all_tasks
  end

  def update
    return render_all_tasks if options_request?
    @task.update_attribute(:description, JSON.parse(request.body.string)["description"])
    render_all_tasks
  end

  def clear_completed
    return render_all_tasks if options_request?
    completed_tasks = Task.where(completed: true)
    completed_tasks.destroy_all
    render_all_tasks
  end

  def destroy
    return render_all_tasks if options_request?
    @task.destroy
    render_all_tasks
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def options_request?
       request.method == "OPTIONS"
    end

    def render_all_tasks
      @tasks = Task.all
      render json: @tasks
    end

    def task_params
      params["task"] = JSON.parse(request.body.string)
      params.require(:task).permit(:description, :completed)
    end
end
