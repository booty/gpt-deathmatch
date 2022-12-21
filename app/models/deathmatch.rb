class Deathmatch < ApplicationRecord
  belongs_to :user
  has_many :deathmatch_votes
end
