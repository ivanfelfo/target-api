class OneSignalService
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def call
    included_targets = OneSignal::IncludedTargets.new(include_email_tokens: [user.email])
    notification = OneSignal::Notification.new(headings: notification_headings,
                                               contents: notification_contents,
                                               included_targets: included_targets,
                                               email_subject: notification_email_subject,
                                               template_id: notification_template_id)
    OneSignal.send_notification(notification)
  end

  private

  def notification_headings
    OneSignal::Notification::Headings.new(en: I18n.t('onesignal.notification.headings'))
  end

  def notification_contents
    OneSignal::Notification::Contents.new(en: I18n.t('onesignal.notification.contents'))
  end

  def notification_email_subject
    I18n.t('onesignal.notification.email_subject')
  end

  def notification_template_id
    Rails.application.credentials.onesignal[:template_id]
  end
end
