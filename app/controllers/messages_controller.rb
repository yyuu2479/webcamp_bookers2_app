class MessagesController < ApplicationController
  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.create(message_params)
      @room = @message.room
      @messages = @room.messages
    else
      flash[:alert] = "メッセージが送信できませんでした！"
    end
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :message, :room_id).merge(user_id: current_user.id)
  end
end
