module V1
  class ConversationsController < ApiController

    def create
      @conversation = Conversation.create!(conversation_params)
    end

    def index
      @conversations = Conversation.where(user_id1: v1_current_user.id).or(Conversation.where(user_id2: v1_current_user.id))
    end

    private

    def conversation_params
      params.require(:conversation).permit(:user_id1, :user_id2, :topic_id)
    end
  end
end