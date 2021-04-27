module V1
  class DashboardsController < ApplicationController
    def index
      render '/v1/dashboards/index'
    end
  end
end
