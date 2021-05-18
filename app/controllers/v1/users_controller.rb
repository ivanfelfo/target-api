module V1
  class UsersController < ApiController
    before_action :authenticate_v1_user!

    def update
      if current_v1_user.id == params[:id].to_i
        begin
          current_v1_user.update!(account_update_data)
        rescue ArgumentError => e
          render json: e, status: :bad_request
        end
        @user = current_v1_user
      else
        render json: { error: 'Can\'t update other user attributes' }, status: :bad_request
      end
    end

    private

    def account_update_data
      params.require(:user).permit(:gender, :email)
    end
  end
end
