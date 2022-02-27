class Campaign < ApplicationRecord
    belongs_to :user
    has_many :voters, dependent: :delete_all

    has_many :campaings_user
end
