class UsersController < ApplicationController
	protect_from_forgery unless: -> { request.format.json? }
	skip_before_action :require_login, only: [:new, :create]

	def index
		@user = current_user.id
		@events = current_user.hosted_events
	end

	def show
		@user = User.find(params[:id])
		accepted_events_ids = EventsUser.where(user_id: @user.id, accepted: true).pluck(:event_id)
		pending_events_ids = EventsUser.where(user_id: @user.id, accepted: nil).pluck(:event_id)
		declined_events_ids = EventsUser.where(user_id: @user.id, accepted: false).pluck(:event_id)
		@accepted_events = Event.where(id: accepted_events_ids)
		@pending_events = Event.where("events.host != ? and id in (?)", @user.id, pending_events_ids)
		@declined_events = Event.where(id: declined_events_ids)
		unless current_user.id == @user.id
			redirect_to user_path(current_user)
		end
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if user_params[:password] == user_params[:password_confirmation] && @user.save
			session[:user_id] = @user.id
			redirect_to user_path(@user)
		else
			render :new
		end
	end

	def edit
		@user = User.find(params[:id])
		if current_user.id == @user.id
		else
			redirect_to user_path(current_user)
		end
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			redirect_to @user
		else
			render :edit
		end
	end

	def destroy
		User.find(params[:id]).destroy
		redirect_to root_path
	end

	def respond_to_invitation
		@events_user = EventsUser.find_by(event_id: params[:event_id], user_id: params[:user_id])
		if params[:accept] == "true"
			@events_user.accepted = true
		else
			@events_user.accepted = false
		end
		@events_user.save
		redirect_back(fallback_location: root_path)
	end

	private

	def user_params
		params.require(:user).permit(:name, :email, :phone_number, :password, :password_confirmation)
	end

end
