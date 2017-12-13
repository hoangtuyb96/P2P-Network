class Image < ApplicationRecord
  has_many :commentable, :as => :commentable

  belongs_to :status

  validates :status_id, presence: true
end
