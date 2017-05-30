Rails.application.config.middleware.use OmniAuth::Builder do
  provider :office365, ENV['OFFICE365_KEY'], ENV['OFFICE365_SECRET'], scope: 'openid'
end
