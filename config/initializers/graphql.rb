module GraphQL
  module Define
    class DefinedObjectProxy
      include Rails.application.routes.url_helpers
      Rails.application.routes.default_url_options = Rails.application.config.action_mailer.default_url_options
    end
  end
end
