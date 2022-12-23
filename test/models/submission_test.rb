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
#  index_submissions_on_user_id  (user_id)
#
require "test_helper"

class SubmissionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
