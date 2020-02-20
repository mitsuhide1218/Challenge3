class UsersController < ApplicationController
	before_action :authenticate_user!,except:[:about]

	def show
		@book = Book.new
		@user = User.find(params[:id])
		@books = @user.books
	end

	def edit
		@user = User.find(params[:id])
		if @user.id != current_user.id
			flash[:notice] = '権限がありません'
			redirect_to user_path(current_user.id)
		end
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
		redirect_to user_path(current_user),notice: 'successfully'
		else
		render 'edit'
		end
	end

	def index
		@users = User.all
		@user = User.find(current_user.id)
		@book = Book.new
	end

	def about
	end


	private
	def user_params
		params.require(:user).permit(:name, :introduction, :profile_image)
	end



end
