class Like < ApplicationRecord
  belongs_to :likeable, :polymorphic => true
  belongs_to :user

  validates :user_id, presence: true

  lambda_find_like = lambda do |likeable_id, likeable_type, user_id|
    where likeable_id: likeable_id,
      likeable_type: likeable_type, user_id: user_id
  end

  scope :find_like, lambda_find_like
end
