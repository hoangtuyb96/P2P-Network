require "elasticsearch/model"
class User < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  ATTRIBUTES_PARAMS = %i(email password password_confirmation fullname address).freeze
  ATTRIBUTES_PARAMS_UPDATE = %i(fullname sex address job birthday avatar)
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :statuses
  has_many :report_from_users, class_name: Report.name, :as => :reportable
  has_many :reports
  has_many :notification_from_users, class_name: Notification.name,
    :as => :notificationable
  has_many :notifications
  has_many :comments
  has_many :likes
  has_many :group_user, class_name: GroupMember.name, dependent: :destroy
  has_many :group_joined, through: :group_user, source: :group
  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: "sender_id", dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: "accepter_id", dependent: :destroy
  has_many :request_sending_friend, through: :active_relationships,
    source: :accepter
  has_many :request_accept_friend, through: :passive_relationships,
    source: :sender
  has_many :group_members

  mount_uploader :avatar, AvatarUploader

  validates :email, presence: true,
    length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX}
  validates :fullname, presence: true

  settings index: {number_of_shards: 1} do
    mappings dynamic: "false" do
      indexes :fullname, analyzer: "english"
      indexes :email, analyzer: "english"
      indexes :address, analyzer: "english"
    end
  end

  class << self
    def search query
      __elasticsearch__.search(
        {
          query: {
            multi_match: {
              query: query,
              fields: ["fullname^5", "email^5", "address"]
            }
          }
        }
      )
    end
  end
end

User.__elasticsearch__.client.indices.delete index: User.index_name rescue nil
User.__elasticsearch__.client.indices.create \
  index: User.index_name,
  body: { settings: User.settings.to_hash, mappings: User.mappings.to_hash }
User.import
