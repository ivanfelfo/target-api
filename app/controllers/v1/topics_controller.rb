module V1
  class TopicsController < ApplicationController
    before_action :authenticate_v1_user!

    def index
      @pagy, @topics = pagy(Topic.all, items: ApplicationController::PAGY_LIMIT)
    end
  end
end
