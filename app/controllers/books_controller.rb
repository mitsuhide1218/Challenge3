class BooksController < ApplicationController
	before_action :authenticate_user!

	def new
		@book = Book.new
	end

	def create
		@book = Book.new(book_params)
		@book.user_id = current_user.id

		if @book.save
		redirect_to book_path(@book.id),notice: 'successfully'
		else
		@books = Book.all
		@user = current_user
		render "index"
		end
	end

	def index
		@book = Book.new
		@books = Book.all
		@user = current_user
	end

	def show
		@book = Book.find(params[:id])
		@books = Book.all
		@user = User.find(current_user[:id])
	end

	def edit
		@book = Book.find(params[:id])
		if @book.user.id != current_user.id
			flash[:notice] = '権限がありません'
			redirect_to books_path
		end
	end

	def update
		@book = Book.find(params[:id])
		@book.user_id = current_user.id

		if @book.update(book_params)
		redirect_to book_path, notice: 'successfully'
		else
		render 'edit'
		end
	end


	def destroy
		book = Book.find(params[:id])
		book.destroy
		redirect_to books_path
	end


	private
	def book_params
		params.require(:book).permit(:title, :body )
	end




end
