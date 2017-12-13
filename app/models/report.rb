class Report < ApplicationRecord
  belongs_to :reportable, :polymorphic => true
  belongs_to :user

  validates :user_id, presence: true
end
