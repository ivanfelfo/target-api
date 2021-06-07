describe 'POST v1/conversations', type: :request do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let(:topic) { create(:topic) }
  let(:params) { { conversation: { user_id2: user2.id, topic_id: topic.id } } }
  subject { get v1_conversations_path, params: params, as: :json }

  context 'when the user is logged in' do
    sign_in(:user1)

    it 'creates a conversation in the DB' do
      subject
      conversation = Conversation.last
      expect(conversation.user_id1).to eq(user1.id)
      expect(conversation.user_id2).to eq(user2.id)
      expect(conversation.topic_id).to eq(topic.id)
    end

    it 'will change the conversation count by 1' do
      expect { subject }.to change(Conversation, :count).by(1)
    end

    it 'returns http success' do
      subject
      expect(response).to have_http_status(200)
    end

    context 'when trying to create a conversation with the same user' do
      let(:params) { { conversation: { user_id2: user1.id, topic_id: topic.id } } }

      it 'returns error' do
        subject
        expect(json['errors']['user_id1']).to eq(["Can't create a conversation with yourself."])
      end

      it 'won\'t change conversation count' do
        expect { subject }.not_to change(Conversation, :count)
      end

      it 'returns http bad request' do
        subject
        expect(response).to have_http_status(400)
      end
    end
  end

  context 'when the user isn\'t logged in' do
    it 'returns http unauthorized' do
      subject
      expect(response).to have_http_status(401)
    end

    it 'doesn\'t change the conversation count' do
      expect { subject }.not_to change(Conversation, :count)
    end
  end
end
