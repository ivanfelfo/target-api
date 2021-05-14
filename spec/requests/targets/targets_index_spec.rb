describe 'GET v1/targets', type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let!(:created_targets) { create_list(:target, 10, user: user) }
  before do
    stub_const('ApplicationController::PAGY_LIMIT', 5)
  end
  subject { get v1_targets_path, as: :json }

  context 'when user is logged in' do
    sign_in(:user)

    context 'when there are other users targets' do
      let!(:targets) { create_list(:target, 3, user: other_user) }
      let!(:created_targets) { create_list(:target, 2, user: user) }

      it 'returns the logged user targets' do
        subject
        expect(json['targets'].map { |target| target['id'] }).to eq(created_targets.map(&:id))
      end
    end

    it 'returns http code success' do
      subject
      expect(response).to have_http_status(200)
    end

    it 'returns same number of created_targets' do
      subject
      expect(json['pagy']['total_count'].to_i).to eq(10)
    end

    it 'returns 2 pages because of PAGY_LIMIT' do
      subject
      expect(json['pagy']['total_pages'].to_i).to eq(2)
    end

    it 'returns 5 targets because of PAGY_LIMIT' do
      subject
      expect(json['targets'].count).to eq(5)
    end

    it 'returns the same user_id as the created target' do
      subject
      expect(json['targets'][0]['user_id']).to eq(user.id)
    end

    it 'returns the same id as the created target' do
      subject
      expect(json['targets'][0]['id']).to eq(created_targets[0].id)
    end

    it 'returns the same topic_id as the created target' do
      subject
      expect(json['targets'][0]['topic_id']).to eq(created_targets[0].topic_id)
    end

    it 'returns the same title as the created target' do
      subject
      expect(json['targets'][0]['title']).to eq(created_targets[0].title)
    end

    it 'returns the same radius as the created target' do
      subject
      expect(json['targets'][0]['radius']).to eq(created_targets[0].radius.to_s)
    end

    it 'returns the same latitude as the created target' do
      subject
      expect(json['targets'][0]['latitude']).to eq(created_targets[0].latitude.to_s)
    end

    it 'returns the same longitude as the created target' do
      subject
      expect(json['targets'][0]['longitude']).to eq(created_targets[0].longitude.to_s)
    end

    it 'returns the same description as the created target' do
      subject
      expect(json['targets'][0]['description']).to eq(created_targets[0].description)
    end

    it 'returns the targets and pagy keys' do
      subject
      expect(json.keys).to contain_exactly('targets', 'pagy')
    end

    it 'returns total_count and total_pages keys' do
      subject
      expect(json['pagy'].keys).to contain_exactly('total_count', 'total_pages')
    end

    it 'returns every target key' do
      subject
      expect(json['targets'][0].keys).to contain_exactly('id', 'topic_id', 'user_id', 'longitude',
                                                         'latitude', 'title', 'radius',
                                                         'created_at', 'updated_at', 'description')
    end
  end

  context 'when user isn\'t logged in' do
    it 'returns http code unauthorized' do
      subject
      expect(response).to have_http_status(401)
    end
  end
end
