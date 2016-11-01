class EventsController < ApplicationController
	before_action :require_login

	require 'twitter'

	def index
		@events = current_user.events
		@hosted_events = current_user.hosted_events
	end

	def show
		@event = Event.find(params[:id])
		@user = current_user
		invitation = Invitation.new(@user, @event)
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
		@user = current_user
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
		@user = User.find_by(email: params[:email])
		unless @user
			fz=FuzzyMatch.new(User.all, :read => :email)
			@user = fz.find(params[:email])
		end
		if @user
			# byebug
			@event = Event.find(params[:id])
			@user.events << @event
			@host = @user.find_host(@event)
			UserMailer.invitation_email(@user, @event, @host).deliver_now
			flash[:notice] = "Successfully invited #{@user.email}"
		else
			flash[:notice] = "Sorry, we couldn't find that user"
		end
		redirect_back(fallback_location: root_path)
	end

	private

	def event_params
		params.require(:event).permit(:name, :address, :start_date, :end_date, :description)
	end

end
