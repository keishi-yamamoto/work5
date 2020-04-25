class BookCommentsController < ApplicationController
	before_action :ensure, only: [:destroy]

	def create
		@book = Book.find(params[:book_id])
		@book_comment = BookComment.new(book_comment_params)
		@book_comment.user_id = current_user.id
		@book_comment.book_id = @book.id
		if @book_comment.save
      redirect_to book_path(@book), notice: "successfully created comment!"
    else
      @user = User.find(@book.user_id)
      @post_book = Book.new
      render  'books/show'
    end
  end
  def destroy
    book = Book.find(params[:book_id])
    comment = BookComment.find(params[:id])
    comment.destroy
    redirect_to book_path(book), notice: "successfully delete comment!"
  end

  private
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
  def ensure
    if current_user.id != BookComment.find(params[:id]).user_id
     redirect_to root_path
   end
 end
end