require 'csv'

class Developer < ApplicationRecord
  has_many :memberships
  has_many :teams, through: :memberships

  has_one :github_user, dependent: :destroy

  validates :username, presence: true

  def self.search(search)
    joins(:github_user).where("github_users.name ILIKE ? OR github_users.login ILIKE ? OR ? ILIKE ANY(ARRAY[github_users.prefered_languages])", 
                              "%#{search}%", "%#{search}%", [search]).references(:github_user)
  end

  def self.by_group(target_group, groups_csv)
    group = []
    if groups_csv != nil
      groups_csv.split('|').each do |row|
        curr_row = row.split(',')
        if curr_row[0] == target_group
          curr_row.each do |login|
            group += [login.downcase]
          end
        end
      end
    end

    if group
      joins(:github_user).where("lower(github_users.login) IN (?)", group)
    else
      all
    end
  end

  def self.hireable(hireable)
    where("github_users.hireable = ?", hireable)
  end
end
