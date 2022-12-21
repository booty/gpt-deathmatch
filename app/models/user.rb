class User < ApplicationRecord
  has_many :deathmatches
  has_many :submissions
end
