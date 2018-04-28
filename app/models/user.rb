class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :owned_groups, class_name: "Group", dependent: :destroy, foreign_key: "owner_id"
  has_many :memberships
  has_many :groups, through: :memberships
  has_many :owners, dependent: :destroy
  has_many :games, through: :owners
  has_many :ratings, dependent: :destroy
  has_many :rated_games, through: :ratings, source: :game
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships, source: :friend
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create
  def friends?(u)
    return self.friends.include?(u) && u.friends.include?(self)
  end
end
