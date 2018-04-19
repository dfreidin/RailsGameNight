class Game < ActiveRecord::Base
    has_many :owners
    has_many :owned_users, through: :owners, source: :user
    has_many :ratings
    has_many :rated_users, through: :ratings, source: :user
    validates :bgg_id, presence: true
end
