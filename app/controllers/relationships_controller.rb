class RelationshipsController < ApplicationController
  def followings
    user = User.find(params[:user_id])
    @users = user.following_user
  end

  def followeds
    user = User.find(params[:user_id])
    @users = user.follower_user
  end



  def create
    current_user.follow(params[:user_id])
    @user = User.find(params[:user_id])

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

  def destroy
    current_user.unfollow(params[:user_id])
    @user = User.find(params[:user_id])
  end

end
