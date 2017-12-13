class Relationship < ApplicationRecord
  belongs_to :accepter, class_name: User.name
  belongs_to :sender, class_name: User.name

  validates :sender_id, presence: true
  validates :accepter_id, presence: true
end
