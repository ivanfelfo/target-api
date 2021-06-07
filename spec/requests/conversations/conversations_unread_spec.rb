describe 'GET v1/conversations/unread', type: :request do
  let(:user1) { create(:user) }
  subject { get v1_conversations_unread_path, as: :json }

  context 'when the user is logged in' do
    sign_in(:user1)

    context 'when the user has unread conversations' do
      let!(:unread_conversation1) { create(:conversation, user_id1: user1.id) }
      let!(:unread_conversation2) { create(:conversation, user_id1: user1.id) }
      let!(:message) { create(:message, user: user1, conversation_id: unread_conversation1.id) }
      let!(:read_conversation) { create(:conversation, user_id1: user1.id, read: true) }

      it 'returns unread conversations' do
        subject
        expect(json['conversations'].count).to eq(2)
        expect(json['conversations'][0]['id']).to eq(unread_conversation1.id)
        expect(json['conversations'][1]['id']).to eq(unread_conversation2.id)
      end

      it 'returns unread messages count in the unread conversation' do
        subject
        expect(json['conversations'][0]['unread_messages_count']).to eq(1)
        expect(json['conversations'][1]['unread_messages_count']).to eq(0)
      end

      it 'returns code success' do
        expect(subject).to eq(200)
      end
    end

    context 'when the user doesn\'t have unread conversations' do
      it 'returns error' do
        subject
        expect(json['error']).to eq("You don't have unread conversations")
      end

      it 'returns code bad request' do
        expect(subject).to eq(400)
      end
    end
  end
end
