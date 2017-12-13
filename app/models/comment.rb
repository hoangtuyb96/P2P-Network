class Comment < ApplicationRecord
  has_many :likes, :as => :likeable

  belongs_to :commentable, :polymorphic => true
  belongs_to :user

  validates :user_id, presence: true
end