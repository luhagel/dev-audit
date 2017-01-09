class Membership < ApplicationRecord
  belongs_to :developer
  belongs_to :team
end
