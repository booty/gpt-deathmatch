# frozen_string_literal: true

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
  test "the truth" do
    assert true
  end

  test "creates a token if email is valid" do
    sesh = Session.find_or_create_by_email_address(
      email_address: User.first.email_address,
      ip_address: "123.123.123.123",
    )

    assert sesh
  end

  test "raises error if email is invalid" do
    assert_raises(Session::UserNotFound) do
      sesh = Session.find_or_create_by_email_address(
        email_address: "zzzzzz",
        ip_address: "123.123.123.123",
      )
    end
  end

  test "doesn't create dupe tokens" do
    2.times do
      Session.find_or_create_by_email_address(
        email_address: User.first.email_address,
        ip_address: "123.123.123.123",
      )
    end

    assert_equal(1, Session.count)
  end

  test "old tokens get purged" do
    Session.create!(
      user_id: User.last.id,
      ip_address: "123.123.123.123",
      created_at: 999.days.ago,
    )

    sesh = Session.find_or_create_by_email_address(
      email_address: User.first.email_address,
      ip_address: "123.123.123.123",
    )

    assert_equal(
      0,
      Session.where(user_id: User.last.id).count,
    )
  end
end
