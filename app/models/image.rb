class Image < ApplicationRecord
  has_many :comments, :as => :commentable
  has_many :likes, :as => :likeable
  has_many :reports, :as => :reportable

  belongs_to :status

  mount_uploader  :link, ImageUploader
end
