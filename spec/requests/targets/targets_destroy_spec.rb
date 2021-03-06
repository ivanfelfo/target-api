describe 'DELETE /v1/targets/{id}', type: :request do
  context 'when the user is logged in' do
    let(:user) { create(:user) }
    let!(:target_of_the_user) { create(:target, user_id: user.id) }
    let(:other_target) { create(:target) }
    sign_in(:user)

    it 'deletes a created target that is owned' do
      delete v1_target_path(target_of_the_user.id)
      expect(response).to have_http_status(:success)
      target_deleted = Target.find_by(id: target_of_the_user.id)
      expect(target_deleted).to be_nil
    end

    it 'is not allowed to delete someone else\'s target' do
      expect { delete v1_target_path(other_target.id) }
        .to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  context 'when the user is not logged in' do
    let(:target) { create(:target) }

    it 'responds with unauthorized' do
      delete v1_target_path(target.id)
      expect(response).to have_http_status(:unauthorized)
    end

    it 'doesn\'t change the target count' do
      delete v1_target_path(target.id)
      expect { subject }.not_to change(Target, :count)
    end
  end
end
