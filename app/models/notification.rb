class Notification < ApplicationRecord
  belongs_to :notificationable, :polymorphic => true
  belongs_to :user

  validates :user_id, presence: true
end
