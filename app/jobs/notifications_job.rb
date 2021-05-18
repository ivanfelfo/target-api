class NotificationsJob < ApplicationJob
  def perform(user)
    OneSignalService.new(user).call
  end
end
