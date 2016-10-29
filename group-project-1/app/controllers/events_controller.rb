class EventsController < ApplicationController
	before_action :require_login

	def index
	end

	def show
		@event = Event.find(params[:id])
		accepted_invitees_ids = EventsUser.where(event_id: @event.id, accepted: true).pluck(:user_id)
		declined_invitees_ids = EventsUser.where(event_id: @event.id, accepted: false).pluck(:user_id)
		pending_invitees_ids = EventsUser.where(event_id: @event.id, accepted: nil).pluck(:user_id)
		@accepted_invitees = User.where(id: accepted_invitees_ids)
		@declined_invitees = User.where(id: declined_invitees_ids)
		@pending_invitees = User.where(id: pending_invitees_ids)
		@current_user = current_user.id
		@tasks = @event.tasks
	end

	def new
		@event = Event.new
	end

	def create
		@event = Event.new(event_params)
		if @event.save
			@event.users << current_user
			@event.host = session[:user_id]
			@event.save
			redirect_to event_path(@event)
		else
			render :new
		end
	end

	def edit
		@event = Event.find(params[:id])
		@user = User.find(@event.host)
		if current_user.id == @user.id
		else
			redirect_to @user
		end
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
		redirect_to user_path(session[:user_id])
	end

	private

	def event_params
		params.require(:event).permit(:name, :address, :start_date, :end_date, :description)
	end

end
