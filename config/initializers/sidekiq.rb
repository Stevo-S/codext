require 'sidekiq'

Sidekiq.configure_server do |config|
    config.redis = { namespace: 'codext', url: 'redis://localhost:6379/18' }
end

Sidekiq.configure_client do |config|
    config.redis = { namespace: 'codext', url: 'redis://localhost:6379/18' }
end

