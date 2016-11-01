class EventsController < ApplicationController
	before_action :require_login

	require 'twitter'

	def index
		@user = current_user.id
	end

	def show
		@event = Event.find(params[:id])
		@user = current_user
		invitation = Invitation.new(@event)
		@accepted = invitation.accepted_invitees
		@declined = invitation.declined_invitees
		@pending = invitation.pending_invitees
		@tasks = @event.tasks
		@host = @user.find_host(@event)
		# @host = User.find(@event.host)
		# Twitter.favorites("railscast",count: 1)
	end

	def yelp
		redirect_to "https://www.yelp.com/search?find_desc=&find_loc=#{params[:city]}&ns=1"
	end

	def twitter
		@twitter = Twitter.search("to:justinbieber marry me", result_type: "recent").take(3).collect do |tweet|
  		"#{tweet.user.screen_name}: #{tweet.text}"
		end
	end

	def new
		@event = Event.new
		@user = current_user.id 
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

	def invite
		@event = Event.find(params[:id])
		@user = User.find_by(email: params[:email])
		invitation = Invitation.new(@event)
		if !@user && params[:new_user] == "1"
			@user = User.create(name: "Fellow Oddter", email: params[:email], password: 'new_user', phone_number: "0123456789")
			@user.events << @event
			new_user = true
			UserMailer.invitation_email(@user, @event, true).deliver_now
			flash[:notice] = "Successfully invited #{@user.email}"
		elsif !@user && params[:new_user] != "1"
			fz=FuzzyMatch.new(User.all, :read => :email)
			@user = fz.find(params[:email])
			flash[:notice] = "Sorry, we couldn't find that user" unless @user
		end
		if @user && !invitation.exists?(@user)
			@user.events << @event
			UserMailer.invitation_email(@user, @event).deliver_now
			flash[:notice] = "Successfully invited #{@user.email}"
		end
		redirect_back(fallback_location: root_path)
	end

	private

	def event_params
		params.require(:event).permit(:name, :address, :start_date, :end_date, :description)
	end

end
