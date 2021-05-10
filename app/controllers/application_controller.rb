class ApplicationController < ActionController::API
  PAGY_LIMIT = 20

  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pagy::Backend

  rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid

  def render_record_invalid(exception)
    logger.info { exception }
    render json: { errors: exception.record.errors.as_json }, status: :bad_request
  end
end
