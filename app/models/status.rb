class Status < ApplicationRecord
  has_many :images
  has_many :likes, :as => :likeable
  has_many :comments, :as => :commentable
  has_many :reports, :as => :reportable
  has_many :notifications, :as => :notificationable

  belongs_to :user

  validates :user_id, presence: true
end
