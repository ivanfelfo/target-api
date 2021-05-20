describe 'GET v1/messages/:id', type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:conversation) { create(:conversation, user_id1: user.id) }
  let(:other_conversation) { create(:conversation) }
  let!(:created_messages) { create_list(:message, 10, user: user, conversation: conversation) }
  let!(:other_messages) do
    create_list(:message, 10, user: other_user, conversation: other_conversation)
  end
  before do
    stub_const('ApiController::PAGY_LIMIT', 5)
  end

  context 'when user is logged in' do
    sign_in(:user)

    context 'when the user tries to get messages from a conversation he participates in' do
      it 'returns 5 messages because of PAGY_LIMIT' do
        get "/v1/messages/#{conversation.id}", as: :json
        expect(json['messages'].count).to eq(5)
      end

      it 'returns 2 pages because of PAGY_LIMIT' do
        get "/v1/messages/#{conversation.id}", as: :json
        expect(json['pagy']['total_pages']).to eq(2)
      end

      it 'returns 10 messages total_count' do
        get "/v1/messages/#{conversation.id}", as: :json
        expect(json['pagy']['total_count']).to eq(10)
      end
    end

    context 'when the user tries to get messages from a conversation he doesn\'t take part in' do
      it 'returns error' do
        get "/v1/messages/#{other_conversation.id}", as: :json
        expect(json['error'])
          .to eq("The conversation doesn't exist or you don't participate in it.")
      end

      it 'returns code bad request' do
        expect(get("/v1/messages/#{other_conversation.id}", as: :json)).to eq(400)
      end
    end
  end
end
