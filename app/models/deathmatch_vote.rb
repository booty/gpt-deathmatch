class DeathmatchVote < ApplicationRecord
  belongs_to :deathmatch
  belongs_to :submission
end
