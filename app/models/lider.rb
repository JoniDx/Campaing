class Lider < ApplicationRecord
    belongs_to :user
    has_many :voters, dependent: :delete_all

end
