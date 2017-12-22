class NotificationWhenBeFollowedService
  def initialize params
    @sender = params[:sender]
    @accepter = params[:accepter]
  end

  def perform
    create_notification
    NotificationBroadcastJob.perform_later(accepter.notifications.count, notification)
  end

  private

  attr_reader :sender, :accepter, :notification, :notification_content

  def create_notification
    @notification_content =
      I18n.t("notifications.be_followed", sender_name: sender.fullname)
    @notification = Notification.create! user_id: accepter.id,
      notificationable_id: sender.id, notificationable_type: User.name,
      content: @notification_content
  end
end
