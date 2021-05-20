module V1
  class ConfirmationsController < Devise::ConfirmationsController
    private

    def after_confirmation_path_for(_resource_name, resource)
      sign_in(resource)
      v1_dashboards_path
    end
  end
end
