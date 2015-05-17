OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, FACEBOOK_ID, FACEBOOK_SECRET, {strategy_class: OmniAuth::Strategies::Facebook, provider_ignores_state: true}
end
