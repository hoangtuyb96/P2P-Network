class GroupMember < ApplicationRecord
  belongs_to :group
  belongs_to :user

  validates :user_id, presence: true

  lambda_find_group_member = lambda do |user_id, group_id|
    where user_id: user_id, group_id: group_id
  end

  scope :find_group_member, lambda_find_group_member

  lambda_find_requests = lambda do |group_id|
    where permission: 0, group_id: group_id
  end

  scope :find_requests, lambda_find_requests
end
