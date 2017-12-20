class Comment < ApplicationRecord
  ATTRIBUTES_PARAMS = :content
  has_many :likes, :as => :likeable

  belongs_to :commentable, :polymorphic => true
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true
end
