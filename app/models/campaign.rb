class Campaign < ApplicationRecord
    has_one_attached :image
    belongs_to :user
    has_many :voters, dependent: :delete_all
    has_many :campaings_user
end
