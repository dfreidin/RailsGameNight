class Game < ActiveRecord::Base
    has_many :owners
    has_many :owned_users, through: :owners, source: :user
    has_many :ratings
    has_many :rated_users, through: :ratings, source: :user
    validates :bgg_id, presence: true

    def group_rating group
        self.ratings.where(user: group.members).average(:rating)
    end
end
