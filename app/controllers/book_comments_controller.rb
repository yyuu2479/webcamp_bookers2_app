class BookCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @book_comment = BookComment.new(book_comment_params)
    @book_comment.user_id = current_user.id
    @book_comment.book_id = @book.id
    unless @book_comment.save
      render 'error'
    end
    
    @book_comments = @book.book_comments
  end

  def destroy
    @book = Book.find(params[:book_id])
    @book_comment = BookComment.find(params[:id])
    @book_comment.destroy
    
    @book_comments = @book.book_comments
  end



  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end



end
