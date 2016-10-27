class SuppliesController < ApplicationController

	def index
	end

	def show
		@supply = Supply.find(params[:id])
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

	def supply_params
		params.require(:supply).permit(:name, :quantity, :unit_cost)
	end

end
