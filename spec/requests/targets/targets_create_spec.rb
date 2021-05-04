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
      expect(response).to have_http_status(200)
    end

    context 'when passing an invalid parameter' do
      let(:params) do
        { target: { title: 'Burgers', latitude: 'x', longitude: 1, radius: 2, topic_id: topic.id } }
      end

      it 'will return http forbidden' do
        subject
        expect(response.status).to eq(403)
      end
    end
  end

  context 'when user is not logged in' do
    it 'returns http unauthorized' do
      subject
      expect(response).to have_http_status(401)
    end

    it 'doesn\t change the target count' do
      expect { subject }.not_to change(Target, :count)
    end
  end

  context 'when user is not logged in' do
    it 'returns http code 404' do
      subject
      expect(response).to have_http_status(401)
    end
  end
end
