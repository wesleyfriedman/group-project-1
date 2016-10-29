class UsersController < ApplicationController
	protect_from_forgery unless: -> { request.format.json? }
	skip_before_action :require_login, only: [:new, :create]

	# def index --> admin?
	# end

	def show
		@user = User.find(params[:id])
		accepted_events_ids = EventsUser.where(user_id: @user.id, accepted: true).pluck(:event_id)
		pending_events_ids = EventsUser.where(user_id: @user.id, accepted: nil).pluck(:event_id)
		@accepted_events = Event.where(id: accepted_events_ids)
		@pending_events = Event.where(id: pending_events_ids)
		if current_user.id == @user.id
		else
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

	def accept_invitation
		# byebug
		@user = current_user
		@events_user = EventsUser.where(event_id: params[:id], user_id: @user.id)
		@events_user.accepted = true
	end

	private

	def user_params
		params.require(:user).permit(:name, :email, :phone_number, :password, :password_confirmation)
	end

end
