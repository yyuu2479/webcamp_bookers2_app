class UsersController < ApplicationController
    def index
        @users = User.all
        @book = Book.new
    end

    def show
        @user = User.find(params[:id])
        @book = Book.new
        @current_user_entry = Entry.where(user_id: current_user.id)
        @user_entry = Entry.where(user_id: @user.id)

        unless @user.id == current_user.id
            @current_user_entry.each do |cu|
                @user_entry.each do |u|
                    if cu.room_id == u.room_id
                        @is_room = true
                        @room_id = cu.room_id
                    end
                end
            end
            unless @is_room
                @room = Room.new
                @entry = Entry.new
            end
        end
    end

    def edit
        @user = User.find(params[:id])
        if @user.id != current_user.id
            redirect_to user_path(current_user.id)
        end
    end

    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            flash[:notice] = "You have updated user successfully."
            redirect_to user_path(@user.id)
        else
            render :edit
        end
    end


    private

    def user_params
        params.require(:user).permit(:name, :introduction, :profile_image)
    end

end
