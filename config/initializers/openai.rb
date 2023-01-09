access_token = ENV.fetch("OPENAI_ACCESS_TOKEN", nil)
if Rails.env.test?
  return unless access_token

  raise ArgumentError, "Shouldn't specify OPENAI_ACCESS_TOKEN in the test environment. " \
                       "silly. Stub things out instead."
else
  Ruby::OpenAI.configure do |config|
    config.access_token = access_token
    # Optional...
    # config.organization_id = ENV.fetch('OPENAI_ORGANIZATION_ID')
  end
end
