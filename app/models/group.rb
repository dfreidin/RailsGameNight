class Group < ActiveRecord::Base
  belongs_to :owner, class_name: "User"
  has_many :memberships, dependent: :destroy
  has_many :members, through: :memberships, source: :user
  validates :name, :owner, presence: true
end
