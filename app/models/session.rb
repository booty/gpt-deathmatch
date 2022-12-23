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
class Session < ApplicationRecord
  MAX_SESSION_TTL_DAYS = 30

  class UserNotFound < StandardError; end

  belongs_to :user

  before_validation :generate_guid

  def self.find_or_create_by_email_address(email_address:, ip_address:)
    purge_old_tokens # ULTRA KLUDGE!

    user = User.find_by(email_address: email_address)
    raise UserNotFound unless user

    self.find_or_create_by!(
      user: user,
      ip_address: ip_address,
    )
  end

  private_class_method def self.purge_old_tokens
    self.where("created_at < ?", Time.current - 30.days).delete_all
  end

  private

  def generate_guid
    self.guid ||= SecureRandom.uuid
  end
end
