class Status < ApplicationRecord
  ATTRIBUTES_PARAMS = %i(content group_id)

  has_many :images
  has_many :likes, :as => :likeable
  has_many :comments, :as => :commentable
  has_many :reports, :as => :reportable
  has_many :notifications, :as => :notificationable
  accepts_nested_attributes_for :images, allow_destroy: true

  belongs_to :user

  validates :user_id, presence: true
end
