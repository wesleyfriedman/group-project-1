class TasksController < ApplicationController

	def index
	end

	def show
		@task = Task.find(params[:id])
	end

	def new
	end

	def create
	end

	def edit
	end

	def update
	end

	def destroy
	end

	private

	def task_params
		params.require(:task).permit(:name, :description, :user_id, :event_id)
	end

end
