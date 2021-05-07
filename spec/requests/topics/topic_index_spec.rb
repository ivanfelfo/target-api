describe 'GET v1/topics', type: :request do
  let(:user) { create(:user) }
  before do
    create_list(:topic, 10)
    stub_const('ApplicationController::PAGY_LIMIT', 5)
  end
  subject { get v1_topics_path, as: :json }

  context 'when user is logged in' do
    sign_in(:user)

    it 'returns 5 topics because of pagy limit' do
      subject
      expect(json['pagy']['total_count'].to_i).to eq(10)
      expect(json['pagy']['total_pages'].to_i).to eq(2)
      expect(json['topics'].count).to eq(5)
    end

    it 'returns http code success' do
      subject
      expect(response).to have_http_status(200)
    end
  end

  context 'when user is NOT logged in' do
    it 'returns http code unauthorized' do
      subject
      expect(response).to have_http_status(401)
    end
  end
end
