describe 'POST v1/messages/:id', type: :request do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let(:params) { { message: { message: "I'm a message!!" } } }
  let(:conversation) { create(:conversation, user_id1: user1.id) }
  subject { post v1_messages_path(conversation.id), params: params, as: :json }

  context 'when the user is logged in' do
    sign_in(:user1)

    context 'when user tries to create a message in a conversation he participates in' do
      it 'creates a message' do
        subject
        message = Message.last
        expect(message.message).to eq("I'm a message!!")
        expect(message.conversation.user_id1).to eq(user1.id)
      end

      it 'returns code success' do
        expect(subject).to eq(200)
      end

      it 'will change the message count by 1' do
        expect { subject }.to change(Message, :count).by(1)
      end
    end

    context 'when user tries to create a message in a conversation he doesn\'t participate in' do
      let(:conversation) { create(:conversation) }

      it 'doesn\'t change message count' do
        expect { subject }.not_to change(Message, :count)
      end

      it 'returns code bad request' do
        expect(subject).to eq(400)
      end
    end

    context 'when the conversation doesn\'t exist' do
      it 'raises error' do
        expect { post v1_messages_path(450) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  context 'when the user isn\'t logged in' do
    it 'returns http unauthorized' do
      subject
      expect(response).to have_http_status(401)
    end

    it 'doesn\'t change the message count' do
      expect { subject }.not_to change(Message, :count)
    end
  end
end
