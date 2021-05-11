describe 'PUT /v1/users/{id}', type: :request do
  subject { put v1_user_path(user.id), params: params, as: :json }
  let(:params)  { { user: { gender: 'female' } } }
  let(:user) { create(:user, gender: 'male') }
  let(:other_user) { create(:user) }

  context 'when the user is logged in' do
    sign_in(:user)

    context 'when id passed is the same as current_v1_user.id' do
      context 'when params are valid' do
        it 'returns code success' do
          subject
          expect(response).to have_http_status(:success)
        end

        it 'changes gender' do
          subject
          expect(user.reload.gender).to eq('female')
        end
      end

      context 'when params are invalid' do
        let(:params) { { user: { gender: 'x' } } }

        it 'returns code bad_request' do
          subject
          expect(response).to have_http_status(:bad_request)
        end

        it 'doesn\'t change user gender' do
          subject
          expect { subject }.not_to change(user, :gender)
        end
      end
    end

    context 'when id passed isn\'t the same as current_v1_user.id' do
      subject { put v1_user_path(other_user.id), params: params, as: :json }

      it 'is not allowed to update someone else\'s target' do
        subject
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  context 'when the user is not logged in' do
    it 'responds with unauthorized' do
      subject
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
