class Target < ApplicationRecord
  MAX_TARGETS_PER_USER = 10

  acts_as_mappable default_units: :kms,
                   default_formula: :flat,
                   distance_field_name: :distance,
                   lat_column_name: :latitude,
                   lng_column_name: :longitude

  after_create :notify_compatible_targets

  belongs_to :topic
  belongs_to :user

  validates :title, presence: true
  validates :radius, presence: true, numericality: { greater_than: 0 }
  validates :latitude, presence: true, numericality: true
  validates :longitude, presence: true, numericality: true

  validate :user_target_limit

  scope :not_of_user, ->(user_id) { where.not(user_id: user_id) }

  def notify_compatible_targets
    compatible_users = compatible_targets.map(&:user)
    headings = OneSignal::Notification::Headings.new(en: 'Hello!')
    contents = OneSignal::Notification::Contents.new(en: 'hola amigo')
    email_subject = 'yayu'
    template_id = '92394320-eae9-4bf5-9511-185414238460'
    compatible_users.each do |user|
      included_targets = OneSignal::IncludedTargets.new(include_email_tokens: [user.email])
      notification = OneSignal::Notification.new(headings: headings, contents: contents,
                                                 included_targets: included_targets,
                                                 email_subject: email_subject,
                                                 template_id: template_id)
      OneSignal.send_notification(notification)
    end
  end

  private

  def user_target_limit
    return unless user.present? && user.targets.count >= Target::MAX_TARGETS_PER_USER

    errors.add(:user, I18n.t('targets.create.limit_reached', limit: MAX_TARGETS_PER_USER))
  end

  def compatible_targets
    compatible_targets = topic.targets.not_of_user(user_id).to_a
    compatible_targets.select do |compatible_target|
      intersects?(compatible_target)
    end
  end

  def intersects?(compatible_target)
    compatible_target_location = Geokit::LatLng.new(compatible_target.latitude,
                                                    compatible_target.longitude)
    created_target_location = Geokit::LatLng.new(latitude, longitude)
    distance = created_target_location.distance_from(compatible_target_location, units: :kms)
    distance <= compatible_target.radius + radius
  end
end
