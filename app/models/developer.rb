class Developer < ApplicationRecord
  has_many :memberships
  has_many :teams, through: :memberships

  has_one :github_user, dependent: :destroy

  validates :username, presence: true

  def self.search(search)
    joins(:github_user).where("github_users.name ILIKE ? OR github_users.login ILIKE ?", "%#{search}%", "%#{search}%").references(:github_user)
  end
end

