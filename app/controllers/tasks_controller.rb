class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @task = Task.new
    load_tasks_for_current_status
  end

  def show; end

  def new
    @task = Task.new
  end

  def edit; end

  def create
    @task = Task.new(task_params)

    if @task.save
      @task = Task.new
      load_tasks_for_current_status

      respond_to do |format|
        format.html { redirect_to tasks_path(status: @status), notice: "Task created." }
        format.turbo_stream
      end
    else
      load_tasks_for_current_status
      render :index, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      load_tasks_for_current_status

      respond_to do |format|
        format.html { redirect_to tasks_path(status: @status), notice: "Task updated." }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "tasks_section",
            partial: "tasks/tasks_section",
            locals: { tasks: @tasks, status: @status }
          )
        end
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    load_tasks_for_current_status

    respond_to do |format|
      format.html { redirect_to tasks_path(status: @status), notice: "Task deleted." }
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "tasks_section",
          partial: "tasks/tasks_section",
          locals: { tasks: @tasks, status: @status }
        )
      end
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :completed)
  end

  def load_tasks_for_current_status
    @status = params[:status]
    @tasks = filtered_tasks.order(created_at: :desc)
  end

  def filtered_tasks
    case @status
    when "completed"
      Task.completed
    when "pending"
      Task.pending
    else
      Task.all
    end
  end
end
