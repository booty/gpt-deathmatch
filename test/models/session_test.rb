# == Schema Information
#
# Table name: sessions
#
#  id         :integer          not null, primary key
#  guid       :string           not null
#  ip_address :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_sessions_on_guid     (guid)
#  index_sessions_on_user_id  (user_id)
#
require "test_helper"

class SessionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
