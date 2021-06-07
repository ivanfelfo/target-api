module V1
  class RegistrationsController < DeviseTokenAuth::RegistrationsController
    private

    def sign_up_params
      params.require(:user).permit(:email, :password, :password_confirmation, :gender)
    end

    def render_create_success
      render json: { user: resource_data }
    end
  end
end
