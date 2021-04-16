class V1::SessionsController < ApplicationController
    def create
        user = User.where(email: params[:email]).first

        if user && user.valid_password?(params[:password])
            render json: user.to_json(), status: :created
        else
            head(:unauthorized)
        end
    end
end