OneSignal.configure do |config|
  config.app_id =  Rails.application.credentials.onesignal[:app_id]
  config.api_key = Rails.application.credentials.onesignal[:app_key]
  config.api_url = Rails.application.credentials.onesignal[:url]
  config.active = true
end
