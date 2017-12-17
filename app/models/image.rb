class Image < ApplicationRecord
  has_many :commentable, :as => :commentable

  belongs_to :status

  mount_uploader  :link, ImageUploader
end
