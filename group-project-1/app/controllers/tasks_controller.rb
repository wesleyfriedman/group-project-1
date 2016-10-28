class TasksController < ApplicationController

	def index
	end

	def show
		@task = Task.find(params[:id])
	end

	def new
		@task = Task.new
		@@event = Event.find(params[:event_id])
		@users = @@event.users
	end

	def create
		@task = Task.new(task_params)
		@task.event_id = @@event.id
		if @task.save
			redirect_to root_path
			# redirect to event path
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
