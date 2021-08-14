class RelationshipsController < ApplicationController
  def followings
    @user = User.find(params[:user_id])
  end
  
  def followeds
  end
  
  def create
    current_user.follow(params[:user_id])
    redirect_back fallback_location: root_path
  end
  
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_back fallback_location: root_path
  end
  
end
