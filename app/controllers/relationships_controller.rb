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
  end

  def destroy
    current_user.unfollow(params[:user_id])
    
    @user = User.find(params[:user_id])
  end

end
