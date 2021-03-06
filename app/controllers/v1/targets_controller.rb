module V1
  class TargetsController < ApiController
    before_action :authenticate_v1_user!

    def index
      @pagy, @targets = pagy(current_v1_user.targets.order(:id), items: ApiController::PAGY_LIMIT)
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
      params.require(:target).permit(:topic_id, :user_id, :title, :radius, :latitude, :longitude,
                                     :description)
    end
  end
end
