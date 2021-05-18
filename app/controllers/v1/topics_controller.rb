module V1
  class TopicsController < ApiController
    before_action :authenticate_v1_user!

    def index
      @pagy, @topics = pagy(Topic.all, items: ApiController::PAGY_LIMIT)
    end
  end
end
