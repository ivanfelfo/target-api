# frozen_string_literal: true

class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid

  def render_record_invalid(exception)
    logger.info(exception) # for logging
    render json: { errors: exception.record.errors.as_json }, status: :bad_request
  end
end
