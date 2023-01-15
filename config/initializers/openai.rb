if !Rails.env.test?
  access_token = ENV.fetch("OPENAI_ACCESS_TOKEN", nil)
  Ruby::OpenAI.configure do |config|
    config.access_token = access_token
    # Optional...
    # config.organization_id = ENV.fetch('OPENAI_ORGANIZATION_ID')
  end
end
