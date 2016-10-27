class EventsController < ApplicationController

	def index
	end

	def show
		@event = Event.find(params[:id])
	end

	def new
		@event = Event.new
	end

	def create
		@event = Event.new(event_params)
		if @event.save
			redirect_to event_path(@event)
		else
			render :new
		end
	end

	def edit
		@event = Event.find(params[:id])
	end

	def update
		@event = Event.find(params[:id])
		if @event.update(event_params)
			redirect_to @event 
		else
			render :edit 
		end 
	end

	def destroy
		Event.find(params[:id]).destroy
		redirect_to new_event_path 
		# redirect to user pf page 
	end

	private

	def event_params
		params.require(:event).permit(:name, :address, :start_date, :end_date, :description)
	end

end
