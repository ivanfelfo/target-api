module V1
  class TopicsController < ApplicationController
    before_action :authenticate_v1_user!
    after_action { pagy_headers_merge(@pagy) if @pagy }

    def index
      @pagy, @topics = pagy(Topic.all, items: ApplicationController::PAGY_LIMIT)
    end
  end
end
