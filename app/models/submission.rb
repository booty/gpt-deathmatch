# frozen_string_literal: true

# == Schema Information
#
# Table name: submissions
#
#  id           :integer          not null, primary key
#  gpt_model    :string           not null
#  gpt_prompt   :string           not null
#  gpt_response :string           not null
#  response_raw :json
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
  GPT3_MODELS = %w(text-davinci-003 text-curie-001 text-babbage-001 text-ada-001).freeze

  belongs_to :user

  before_validation :set_defaults # run this before fetch_gpt_response
  before_validation :fetch_gpt_response_if_needed

  validates :gpt_model, inclusion: { in: GPT3_MODELS }

  private

  def set_defaults
    self.gpt_model ||= Rails.configuration.x.openai.gpt3_model
  end

  def fetch_gpt_response_if_needed
    self.gpt_response ||= fetch_gpt_response
  end

  def fetch_gpt_response
    self.response_raw = OpenAI::Client.new.completions(
      parameters: {
        model: self.gpt_model,
        prompt: gpt_prompt,
        max_tokens: Rails.configuration.x.openai.gpt3_max_tokens,
      },
    )
    self.gpt_response = response_raw["choices"].first["text"]
  end
end
