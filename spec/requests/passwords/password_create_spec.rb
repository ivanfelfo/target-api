describe 'POST v1/users/password', type: :request do
  let!(:user) { create(:user, password: 'mypass123') }
  subject { post v1_user_password_path, params: params, as: :json }

  context 'with valid params' do
    let(:params) { { email: user.email, redirect_url: '/' } }

    it 'returns a successful response' do
      subject
      expect(response).to have_http_status(:success)
    end

    it 'returns the user email' do
      subject
      expect(json['message']).to match(/#{user.email}/)
    end

    it 'sends an email' do
      expect { subject }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end

  context 'with invalid params' do
    let(:params) { { email: 'notvalid@example.com', redirect_url: '/' } }

    it 'does not return a successful response' do
      subject
      expect(response.status).to eq(404)
    end

    it 'does not send an email' do
      expect { subject }.not_to change { ActionMailer::Base.deliveries.count }
    end
  end
end
