class NotificationsWorker
  include Sidekiq::Worker

  def perform(user)
    OneSignalService.new(user).call
  end
end
