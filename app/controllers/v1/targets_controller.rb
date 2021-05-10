module V1
  class TargetsController < ApplicationController
    before_action :authenticate_v1_user!
    after_action { pagy_headers_merge(@pagy) if @pagy }

    def index
      @pagy, @targets = pagy(current_v1_user.targets.order(:id),
                             items: ApplicationController::PAGY_LIMIT)
    end

    def create
      @target = current_v1_user.targets.create!(target_params)
    end

    def destroy
      target.destroy!
      head :no_content
    end

    private

    def target
      @target ||= current_v1_user.targets.find(params[:id])
    end

    def target_params
      params.require(:target).permit(:topic_id, :user_id, :title, :radius, :latitude, :longitude)
    end
  end
end
