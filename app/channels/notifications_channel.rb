class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notification_#{current_user.id}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
