module V1  
  class MessagesController < ApiController

    def create
      @message = conversation.messages.create!(message_params)
    end

    private

    def conversation
      conversation = Conversation.where(id: params[:conversation_id])
    end

    def message_params
      params.require(:message).permit(:conversation_id, :message)
    end
  end
end