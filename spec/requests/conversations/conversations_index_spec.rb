describe 'GET v1/conversations', type: :request do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  subject { get v1_conversations_path, as: :json }

  context 'when the user is logged in' do
    sign_in(:user1)

    context 'when there are conversations the logged user didn\'t participate in' do
      let!(:created_conversation1) { create(:conversation, user_id1: user1.id) }
      let!(:created_conversation2) { create(:conversation, user_id1: user1.id) }
      let!(:other_conversation) { create(:conversation, user_id1: user2.id) }

      it 'won\'t get others conversations' do
        subject
        expect(json['conversations'][0]['user_id1']).to eq(user1.id)
        expect(json['conversations'][1]['user_id1']).to eq(user1.id)
        expect(json['conversations'].count).to eq(2)
      end

      it 'returns code success' do
        expect(subject).to eq(200)
      end

      it 'returns every conversation key' do
        subject
        expect(json['conversations'][0].keys)
          .to contain_exactly('id', 'user_id1', 'user_id2', 'topic', 'read')
      end
    end

    context 'when the logged user doesn\'t have any conversations' do
      it 'returns error' do
        subject
        expect(json['error']).to eq("You don't have any conversations.")
      end

      it 'returns code bad request' do
        expect(subject).to eq(400)
      end
    end
  end

  context 'when the user isn\'t logged in' do
    it 'returns http code unauthorized' do
      subject
      expect(response).to have_http_status(401)
    end
  end
end
