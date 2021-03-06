class BooksController < ApplicationController
    impressionist :actions => [:show]

    def index
        @book = Book.new
        @books = Book.includes(:favorited_users).sort{|a, b| b.favorited_users.size <=> a.favorited_users.size}
    end

    def show
        @book_new = Book.new
        @book = Book.find(params[:id])
        @book_comment = BookComment.new
        @book_comments = @book.book_comments
        @user = @book.user
        impressionist(@book, nil, unique: [:session_hash.to_s])
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
