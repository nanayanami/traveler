class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    # URLの /rooms/:room_id/messages から room_id を取得する
    @room = Room.find(params[:room_id])
    # その部屋に紐づくメッセージを、現在のユーザーとして作成
    @message = @room.messages.build(message_params)
    @message.user_id = current_user.id

    if @message.save
      redirect_to room_path(@room)
    else
      @messages = @room.messages.includes(:user) 
      @another_entry = @room.entries.where.not(user_id: current_user.id).first
      render "rooms/show",status: :unprocessable_entity
    end
  end

  private

  def message_params
    # room_id は params[:room_id] から取るので、ここでの許可は不要になります
    params.require(:message).permit(:message)
  end
end
