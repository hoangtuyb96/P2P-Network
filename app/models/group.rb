require "elasticsearch/model"
class Group < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  ATTRIBUTES_PARAMS = %i(name about cover)

  has_many :notifications, :as => :notificationable
  has_many :user_group, class_name: GroupMember.name, dependent: :destroy
  has_many :user_in_group, through: :user_group, source: :user
  has_many :group_members
  has_many :statuses

  mount_uploader :cover, CoverGroupUploader

  validates :name, presence: true

  settings index: {number_of_shards: 1} do
    mappings dynamic: "false" do
      indexes :name, analyzer: "english"
      indexes :about, analyzer: "english"
    end
  end

  class << self
    def search query
      __elasticsearch__.search(
        {
          query: {
            multi_match: {
              query: query,
              fields: ["name^5", "about^2"]
            }
          }
        }
      )
    end
  end
end

Group.__elasticsearch__.client.indices.delete index: Group.index_name rescue nil
Group.__elasticsearch__.client.indices.create \
  index: Group.index_name,
  body: { settings: Group.settings.to_hash, mappings: Group.mappings.to_hash }
Group.import
