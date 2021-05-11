describe 'PUT api/v1/users/passwords/', type: :request do
  let(:user) { create(:user, password: 'mypass123') }
  let(:params) do
    { password: 'newpass123', password_confirmation: 'newpass123' }
  end
  sign_in(:user)

  context 'with valid params' do
    it 'returns a successful response' do
      put v1_user_password_path, params: params
      expect(response).to have_http_status(:success)
    end

    # it 'changes user password' do
    #   put v1_user_password_path, params: params
    #   expect(user.reload.password).to eq('newpass123')
    # end
  end

  context 'with invalid params' do
    it 'does not change the password if confirmation does not match' do
      params[:password_confirmation] = 'anotherpass'
      put v1_user_password_path, params: params
      expect(response.status).to eq(422)
    end
  end
end
