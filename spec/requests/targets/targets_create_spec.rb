describe 'POST v1/targets', type: :request do
  let(:user) { create(:user) }
  let(:topic) { create(:topic) }
  let(:params) do
    { target: { title: 'Burgers', latitude: 1, longitude: 1, radius: 2, topic_id: topic.id } }
  end
  subject { post v1_targets_path, params: params, as: :json }

  context 'when user is logged in' do
    sign_in(:user)

    it 'creates a target in the db' do
      subject
      target = Target.last
      expect(target.title).to eq('Burgers')
    end

    it 'will change the target count by 1' do
      expect { subject }.to change(Target, :count).by(1)
    end

    it 'returns http success' do
      subject
      expect(response).to have_http_status(204)
    end
  end

  context 'when user is not logged in' do
    it 'returns http code 404' do
      subject
      expect(response).to have_http_status(401)
    end
  end
end
