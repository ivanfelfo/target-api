module V1
  class UsersController < ApplicationController
    before_action :authenticate_v1_user!

    def update
      current_v1_user.update!(user_params)
      @user = current_v1_user
    end

    private

    def user_params
      params.require(:user).permit(:gender, :email)
    end
  end
end