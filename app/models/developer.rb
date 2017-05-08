class Developer < ApplicationRecord
  has_many :memberships
  has_many :teams, through: :memberships

  has_one :github_user, dependent: :destroy

  validates :username, presence: true

  def self.search(search)
    search_array = []
    search_array += [search]
    joins(:github_user).where("github_users.name ILIKE ? OR github_users.login ILIKE ? OR ? ILIKE ANY(ARRAY[github_users.prefered_languages])", "%#{search}%", "%#{search}%", [search]).references(:github_user)
  end
end

