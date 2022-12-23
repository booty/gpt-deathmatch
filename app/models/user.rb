# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  email_address :string           not null
#  first_name    :string           not null
#  last_name     :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_users_on_email_address  (email_address)
#
class User < ApplicationRecord
  has_many :deathmatches
  has_many :submissions
end
