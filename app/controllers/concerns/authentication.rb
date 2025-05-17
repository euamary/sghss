module Authentication
  extend ActiveSupport::Concern

  class_methods do
    def allow_unauthenticated_access(options = {})
      skip_before_action :require_authentication, options
    end
  end

  included do
    before_action :require_authentication
    after_action :refresh_session
  end

  private

  def require_authentication
    resume_session || render_unauthorized
  end

  def resume_session
    token = request.headers['Authorization']&.split(' ')&.last
    Current.session = Session.find_by(token: token)
  end

  def refresh_session
    if Current.session
      Current.session.regenerate_token!
      response.set_header('Authorization', "Bearer #{Current.session.token}")
    end
  end
  
  def render_unauthorized
    render json: { error: I18n.t('authentication.errors.unauthorized') }, status: :unauthorized
  end
end
