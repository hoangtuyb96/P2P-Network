class Group < ApplicationRecord
  ATTRIBUTES_PARAMS = %i(name about cover)

  has_many :notifications, :as => :notificationable
  has_many :user_group, class_name: GroupMember.name, dependent: :destroy
  has_many :user_in_group, through: :user_group, source: :user
  has_many :group_members
  has_many :statuses

  mount_uploader :cover, CoverGroupUploader

  validates :name, presence: true
end
