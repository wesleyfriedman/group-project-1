class UsersController < ApplicationController

	# def index --> admin?
	# end

	def show
		@user = User.find(params[:id])
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
	end

	private

	def user_params
		params.require(:user).permit(:name, :email, :phone_number, :password, :password_confirmation)
	end

end
