module V1
  class TargetsController < ApplicationController
    before_action :authenticate_v1_user!
    before_action :check_limit, only: :create

    def create
      @target = current_v1_user.targets.create!(target_params)
    end

    def destroy
      target.destroy!
      head :no_content
    end

    private

    def check_limit
      return unless current_v1_user.targets.count >= Target::MAX_TARGETS_PER_USER

      render json: { error: 'error! target limit reached' }, status: :bad_request
    end

    def target
      @target ||= current_v1_user.targets.find(params[:id])
    end

    def target_params
      params.require(:target).permit(:topic_id, :user_id, :title, :radius, :latitude, :longitude)
    end
  end
end
