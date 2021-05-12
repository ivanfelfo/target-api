describe 'PUT api/v1/users/passwords/', type: :request do
  let(:user) { create(:user, password: 'mypass123') }
  sign_in(:user)
  let(:params) do
    { password: 'newpass123', password_confirmation: 'newpass123' }
  end
  subject { put v1_user_password_path, params: params, as: :json }

  context 'with valid params' do
    it 'returns a successful response' do
      subject
      expect(response).to have_http_status(:success)
    end

    it 'changes user password' do
      expect { subject }.to change { user.reload.encrypted_password }
    end
  end

  context 'with invalid params' do
    it 'does not change the password if confirmation does not match' do
      params[:password_confirmation] = 'anotherpass'
      subject
      expect(response.status).to eq(422)
    end
  end
end
