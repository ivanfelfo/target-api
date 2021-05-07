describe 'GET v1/targets', type: :request do
  let(:user) { create(:user) }
  let!(:created_targets) { create_list(:target, 10, user: user) }
  before do
    stub_const('ApplicationController::PAGY_LIMIT', 5)
  end
  subject { get v1_targets_path, as: :json }

  context 'when user is logged in' do
    sign_in(:user)

    it 'returns 5 targets because of pagy limit' do
      subject
      expect(json['pagy']['total_count'].to_i).to eq(10)
      expect(json['pagy']['total_pages'].to_i).to eq(2)
      expect(json['targets'].count).to eq(5)
    end

    it 'returns http code success' do
      subject
      expect(response).to have_http_status(200)
    end

    it 'returns the correct values' do
      subject
      expect(json['targets'][0]['user_id']).to eq(user.id)
      expect(json['targets'][0]['id']).to eq(created_targets[0]['id'])
      expect(json['targets'][0]['topic_id']).to eq(created_targets[0]['topic_id'])
      expect(json['targets'][0]['title']).to eq(created_targets[0]['title'])
      # expect(json['targets'][0]['radius']).to eq(created_targets[0]['radius'])
      # expect(json['targets'][0]['latitude']).to eq(created_targets[0]['latitude'])
      # expect(json['targets'][0]['longitude']).to eq(created_targets[0]['longitude'])
    end

    it 'returns the correct keys' do
      subject
      expect(json.keys).to contain_exactly('targets', 'pagy')
      expect(json['pagy'].keys).to contain_exactly('total_count', 'total_pages')
      expect(json['targets'][0].keys).to contain_exactly('id', 'topic_id', 'user_id', 'longitude',
                                                         'latitude', 'title', 'radius',
                                                         'created_at', 'updated_at')
    end
  end

  context 'when user isn\'t logged in' do
    it 'returns http code unauthorized' do
      subject
      expect(response).to have_http_status(401)
    end
  end
end
