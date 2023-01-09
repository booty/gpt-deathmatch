# == Schema Information
#
# Table name: submissions
#
#  id           :integer          not null, primary key
#  gpt_model    :string           not null
#  gpt_prompt   :string           not null
#  gpt_response :string           not null
#  response_raw :json             not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer          not null
#
# Indexes
#
#  index_submissions_on_gpt_prompt  (gpt_prompt) UNIQUE
#  index_submissions_on_user_id     (user_id)
#
require "test_helper"

class SubmissionTest < ActiveSupport::TestCase
  test "valid factory" do
    SubmissionFactory.submission
  end

  test "fills in gpt_response before creating, but not after subsequent saves" do
    submission = SubmissionFactory.submission(gpt_response: nil, save: false)
    fake_response = Faker::Lorem.sentences.join(" ")

    submission.stub(:fetch_gpt_response, fake_response) do
      submission.save!
    end

    assert_equal(submission.gpt_response, fake_response)

    submission.save!

    assert_equal(submission.gpt_response, fake_response)
  end
end
