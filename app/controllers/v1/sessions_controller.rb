# frozen_string_literal: true

module V1
  class SessionsController < ApplicationController
    def create
      if user&.valid_password?(params[:user][:password])
        assign_session_params
        render json: user, status: :created
      else
        head(:unauthorized)
      end
    end

    def destroy
      session[:user_id] = nil
      session[:email] = nil
      render json: 'signed out!'.to_json
    end

    private

    def user
      User.find_by(email: params[:user][:email])
    end

    def assign_session_params
      session[:user_id] = user.id
      session[:email] = user.email
    end
  end
end
