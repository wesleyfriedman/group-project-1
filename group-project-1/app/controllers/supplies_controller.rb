class SuppliesController < ApplicationController

	def index
	end

	def show
		@supply = Supply.find(params[:id])
	end

	def new
		@supply = Supply.new
	end

	def create
		@supply = Supply.new(supply_params)
		if @supply.save
			redirect_to root_path
			# redirect to event path
		else
			render :new
		end
	end

	def edit
		@supply = Supply.find(params[:id])
	end

	def update
		@supply = Supply.find(params[:id])
		if @supply.update(supply_params)
			redirect_to root_path
			# redirect to event path
		else
			render :edit
		end
	end

	def destroy
		Supply.find(params[:id]).destroy
	end

	private

	def supply_params
		params.require(:supply).permit(:name, :quantity, :unit_cost, :task_id)
	end

end
