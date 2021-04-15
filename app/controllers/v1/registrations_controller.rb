class V1::RegistrationsController < ApplicationController
    
    
    def create
        user = User.new(email: params[:email], gender: params[:gender] ,password: params[:password])
        if user.save!
            render json: user.to_json(), status: :created
        else
            head(:unauthorized)
        end
    end
end
