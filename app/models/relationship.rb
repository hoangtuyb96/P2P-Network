class Relationship < ApplicationRecord
  belongs_to :accepter, class_name: User.name
  belongs_to :sender, class_name: User.name

  validates :sender_id, presence: true
  validates :accepter_id, presence: true

  lambda_find_relationship = lambda do |sender_id, accepter_id|
    where sender_id: sender_id,
      accepter_id: accepter_id
  end

  scope :find_relationship, lambda_find_relationship
end
