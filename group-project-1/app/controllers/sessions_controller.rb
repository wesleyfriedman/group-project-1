class SessionsController < ApplicationController
	skip_before_action :require_login, only: [:new, :create]

	def new
	end

	def create
		user = User.find_by(email: params[:user][:email])
		if user && user.authenticate(params[:user][:password])
			session[:user_id] = user.id
			redirect_to user_path(user)
		else
			flash[:notice] = "Invalid credentials. Please try again."
			redirect_to login_path
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_path
	end


end
