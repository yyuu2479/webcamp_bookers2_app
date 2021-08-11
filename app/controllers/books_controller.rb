class BooksController < ApplicationController
    def index
        @book = Book.new
        @books = Book.all
    end

    def show
        @book_new = Book.new
        @book_comment = BookComment.new
        @book = Book.find(params[:id])
        @user = @book.user
        @book_comments = @book.book_comments
    end

    def edit
        @book = Book.find(params[:id])
        if @book.user_id != current_user.id
            redirect_to books_path
        end
    end

    def create
        @book = Book.new(book_params)
        @book.user_id = current_user.id
        if @book.save
            flash[:notice] = "You have created book successfully."
            redirect_to book_path(@book)
        else
            @books = Book.all
            render :index
        end
    end

    def destroy
        book = Book.find(params[:id])
        book.destroy
        redirect_to books_path
    end

    def update
        @book = Book.find(params[:id])
        if @book.update(book_params)
            flash[:notice] = "You have updated book successfully."
            redirect_to book_path(@book)
        else
            render :edit
        end
    end


    private

    def book_params
        params.require(:book).permit(:title, :body)
    end

end
