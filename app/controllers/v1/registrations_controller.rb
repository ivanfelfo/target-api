# frozen_string_literal: true

module V1
  class RegistrationsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid
    def create
      user = User.new(user_params)
      if user.save!
        render json: user.to_json, status: :created
      else
        head(:unauthorized)
      end
    end

    private

    def render_record_invalid(exception)
      render json: { errors: exception.record.errors.as_json }, status: :bad_request
    end

    def user_params
      params.require(:user).permit(:email, :password, :gender)
    end
  end
end
