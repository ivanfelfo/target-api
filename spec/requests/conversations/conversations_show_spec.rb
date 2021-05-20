describe 'GET v1/conversations/:id', type: :request do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let!(:logged_user_conversation) { create(:conversation, user_id1: user1.id) }
  let!(:other_conversation) { create(:conversation, user_id1: user2.id) }

  context 'when the user is logged in' do
    sign_in(:user1)

    context 'when getting a conversation the user participates in' do
      it 'returns the conversation' do
        get v1_conversations_path(logged_user_conversation.id)
        expect(json['conversations'][0]['id']).to eq(logged_user_conversation.id)
        expect(json['conversations'][0]['user_id1']).to eq(user1.id)
      end

      # it 'updates read attr to true' do
      #   get v1_conversations_path(logged_user_conversation.id)
      #   expect(logged_user_conversation.reload.read).to eq(true)
      # end
    end

    context 'when trying to get a conversation the user doesn\'t participate in' do
      # it 'returns error' do
      #   get v1_conversations_path(other_conversation.id)
      #   byebug
      #   expect(json['error']).to eq()
      # end
    end
  end

  context 'when the user isn\'t logged in' do
    it 'returns http code unauthorized' do
      get v1_conversations_path(logged_user_conversation.id)
      expect(response).to have_http_status(401)
    end
  end
end
