module V1
  class MessagesController < ApiController
    before_action :authenticate_v1_user!
    before_action :check_user_message_conversation, on: :create

    def create
      @message = conversation.messages.create!(params_message)
      conversation.update!(read: false)
    end

    def index
      @pagy, @messages = pagy(conversation.messages.order(id: :desc),
                              items: ApiController::PAGY_LIMIT)
    end

    private

    def check_user_message_conversation
      unless conversation.user_id1 == current_v1_user.id ||
             conversation.user_id2 == current_v1_user.id
        render json: { error: I18n.t('message.index.empty') },
               status: :bad_request
      end
    end

    def conversation
      @conversation ||= Conversation.find(params[:id])
    end

    def params_message
      {
        message: message_params[:message],
        user_id: current_v1_user.id
      }
    end

    def message_params
      params.require(:message).permit(:message)
    end
  end
end
