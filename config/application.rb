require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module SghssApi
  class Application < Rails::Application
    config.load_defaults 8.0
    config.autoload_lib(ignore: %w[assets tasks])
    config.api_only = true
    config.i18n.available_locales = [:en, :'pt-BR']
    config.i18n.default_locale = :'pt-BR'
    config.i18n.fallbacks = [:en]
  end
end
