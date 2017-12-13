class Group < ApplicationRecord
  has_many :notifications, :as => :notificationable
  has_many :user_group, class_name: GroupMember.name, dependent: :destroy
  has_many :user_in_group, through: :user_group, source: :user

  validates :name, presence: true
end
