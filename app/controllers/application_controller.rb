class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pagy::Backend
  PAGY_LIMIT = 20

  rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid
  rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing

  def handle_parameter_missing(exception)
    render json: { error: exception.message }, status: :bad_request
  end

  def render_record_invalid(exception)
    logger.info { exception }
    render json: { errors: exception.record.errors.as_json }, status: :bad_request
  end
end
