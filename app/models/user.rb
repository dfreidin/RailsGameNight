class User < ActiveRecord::Base
  has_secure_password
  has_many :owned_groups, class_name: "Group"
  has_many :memberships
  has_many :groups, through: :memberships
  has_many :owners
  has_many :games, through: :owners
  has_many :ratings
  has_many :rated_games, through: :ratings, source: :game
  has_many :friendships
  has_many :friends, through: :friendships, source: :friend
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create
  validates :email, email: true, allow_nil: true
  def friends?(u)
    return self.friends.include?(u) && u.friends.include?(self)
  end
end
