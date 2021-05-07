module V1
  class UsersController < ApplicationController
    before_action :authenticate_v1_user!

    def update
      @user = current_v1_user.update(user_params)
    end

    private

    def user_params
      require(:user).permit(:gender, :email)
    end
  end
end