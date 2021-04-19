# frozen_string_literal: true

module V1
  class SessionsController < ApplicationController
    def create
      user = User.find_by(email: params[:email])

      if user&.valid_password?(params[:password])
        session[:user_id] = user.id
        session[:email] = user.email
        render json: user.to_json, status: :created
      else
        head(:unauthorized)
      end
    end

    def destroy
      session[:user_id] = nil
      session[:email] = nil
      render json: 'signed out!'.to_json
    end
  end
end
