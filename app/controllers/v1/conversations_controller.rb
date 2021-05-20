module V1
  class ConversationsController < ApiController
    before_action :authenticate_v1_user!

    def create
      @conversation = Conversation.create!(params_conversation)
    end

    def index
      @conversations = Conversation.where(user_id1: current_v1_user.id)
                                   .or(Conversation.where(user_id2: current_v1_user.id))
      return unless @conversations.empty?

      render json: { error: I18n.t('conversation.index.empty') }, status: :bad_request
    end

    def show
      @conversation = conversation_array_show
      @conversation.update!(read: true)
      return unless @conversation.empty?

      render json: { error: I18n.t('conversation.show.empty') }, status: :bad_request
      elseif @conversation.messages.present?
      @conversation.messages.unread.each { |m| m.read = true }
    end

    def unread
      @conversations = Conversation.where({ user_id1: current_v1_user.id,
                                            read: false })
                                   .or(Conversation
                                              .where({ user_id2: current_v1_user.id, read: false }))
      return unless @conversations.empty?

      render json: { error: I18n.t('conversation.get_unread.empty') }, status: :bad_request
    end

    private

    def conversation_array_show
      Conversation.where({ id: params[:id],
                           user_id1: current_v1_user.id })
                  .or(Conversation.where({ id: params[:id],
                                           user_id2: current_v1_user.id }))
    end

    def conversation_params
      params.require(:conversation).permit(:user_id2, :topic_id)
    end

    def params_conversation
      {
        topic_id: conversation_params[:topic_id],
        user_id2: conversation_params[:user_id2],
        user_id1: current_v1_user.id
      }
    end
  end
end
