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
require "test_helper"

class UserTest < ActiveSupport::TestCase
  test ".user factory" do
    UserFactory.user
  end

  test ".user_no_deathmatches factory" do
    assert_equal(
      0,
      UserFactory.user_no_deathmatches.deathmatches.count,
    )
  end
end
