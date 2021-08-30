class RoomsController < ApplicationController
  def create
    @room = Room.create
    @entry1 = Entry.create(user_id: current_user.id, room_id: @room.id)
    @entry2 = Entry.create(entry_room_params)
    redirect_to room_path(@room.id)
  end

  def show
    @room = Room.find(params[:id])
    if Entry.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.messages
      @message = Message.new
      @entrys = @room.entrys
      @another_entry = @entrys.where.not(user_id: current_user.id).first
    else
      redirect_back fallback_location: root_path
    end
  end



  private
  def entry_room_params
    params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id)
  end

end
