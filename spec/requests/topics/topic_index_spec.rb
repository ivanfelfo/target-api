describe 'GET v1/topics', type: :request do
  let(:user) { create(:user) }
  let!(:created_topics) { create_list(:topic, 10) }
  before do
    stub_const('ApiController::PAGY_LIMIT', 5)
  end
  subject { get v1_topics_path, as: :json }

  context 'when user is logged in' do
    sign_in(:user)

    it 'returns http code success' do
      subject
      expect(response).to have_http_status(200)
    end

    it 'returns 5 topics because of pagy limit' do
      subject
      expect(json['pagy']['total_count'].to_i).to eq(10)
      expect(json['pagy']['total_pages'].to_i).to eq(2)
      expect(json['topics'].count).to eq(5)
    end

    it 'returns the correct values' do
      subject
      expect(json['topics'][0]['id']).to eq(created_topics[0].id)
      expect(json['topics'][0]['name']).to eq(created_topics[0].name)
    end

    it 'returns the correct keys' do
      subject
      expect(json.keys).to contain_exactly('topics', 'pagy')
      expect(json['pagy'].keys).to contain_exactly('total_count', 'total_pages')
      expect(json['topics'][0].keys).to contain_exactly('id', 'name', 'created_at', 'updated_at')
    end
  end

  context 'when user is NOT logged in' do
    it 'returns http code unauthorized' do
      subject
      expect(response).to have_http_status(401)
    end
  end
end
