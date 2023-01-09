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
class Submission < ApplicationRecord
  belongs_to :user

  before_save :fetch_gpt_response_if_needed

  private

  def fetch_gpt_response_if_needed
    self.gpt_response ||= fetch_gpt_response
  end

  def fetch_gpt_response
    OpenAI::Client.new.completions(
      parameters: {
        model: "text-davinci-001",
        prompt: "Once upon a time",
        max_tokens: 5,
      },
    )
  end
end
