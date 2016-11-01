class TasksController < ApplicationController

	def index
		@tasks = current_user
	end

	def show
		@task = Task.find(params[:id])
	end

	def complete
		@task = Task.find(params[:id])
		@task.complete = true
		@task.save
		redirect_to event_path(@task.event)
	end

	def new
		@user = current_user
		@task = Task.new
		@users = Event.find(params[:event_id]).users
		@event = Event.find(params[:event_id])
	end

	def create
		@task = Task.new(task_params)
		user = User.find(params[:user_id])
		@task.event_id = params[:event_id]
		@task.user_id = user.id
		if @task.save
			redirect_to event_path(params[:event_id])
		else
			render :new
		end
	end

	def edit
		@task = Task.find(params[:id])
	end

	def update
		@task = Task.find(params[:id])
		if @task.update(task_params)
			redirect_to root_path
			# redirect to event path
		else
			render :edit
		end
	end

	def destroy
		Task.find(params[:id]).destroy
	end

	private

	def task_params
		params.require(:task).permit(:name, :description, :user_id, :event_id, :complete, :id)
	end

end
