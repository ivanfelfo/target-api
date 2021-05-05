module V1
  class TargetsController < ApplicationController
    before_action :authenticate_v1_user!

    def create
      @target = current_v1_user.targets.create!(target_params)
      render_record_valid
    end

    def destroy
      target.destroy!
    end

    private

    def target
      @target ||= current_v1_user.targets.find(params[:id])
    end

    def target_params
      params.require(:target).permit(:topic_id, :user_id, :title, :radius, :latitude, :longitude)
    end

    def render_record_valid
      render json: { target: @target }
    end

    def render_record_invalid
      render json: 'error! record invalid', status: :forbidden
    end
  end
end
