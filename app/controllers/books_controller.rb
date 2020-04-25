class BooksController < ApplicationController
  before_action :ensure, {only: [:edit, :update]}

  def show
  	@book = Book.find(params[:id])
    @user = User.find(@book.user_id)
    @post_book = Book.new
    @book_comment = BookComment.new
  end
  def index
  	@books = Book.all
    @book = Book.new
  end
  def create
  	@book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "successfully created book!"
    else
      @books = Book.all
      render 'index'
    end
  end
  def edit
  	@book = Book.find(params[:id])
  end
  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  		redirect_to @book, notice: "successfully updated book!"
  	else
  		render "edit"
  	end
  end
  def delete
  	@book = Book.find(params[:id])
  	@book.destoy
  	redirect_to books_path, notice: "successfully delete book!"
  end

  def ensure
    if current_user.id != Book.find(params[:id]).user_id
      redirect_to books_path
    end
  end

  private

  def book_params
  	params.require(:book).permit(:title, :body)
  end

end
