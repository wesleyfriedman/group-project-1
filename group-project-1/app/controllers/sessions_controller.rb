class SessionsController < ApplicationController

	def new
	end

	def create
		# byebug
		@user = User.find_by(name: params[:user][:name])
		if @user.authenticate(params[:user][:password])
			session[:user_id] = @user.id
			redirect_to user_path(@user)
		else
			redirect_to login_path
		end
	end

	def session_params
		params.require(:user).permit(:name, :password)
	end

end