class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: "User"
  validates :user, :friend, presence: true
  validate :check_self_friendship
  private
  def check_self_friendship
    errors.add(:friend, "can't be friends with self") if user == friend
  end
end
