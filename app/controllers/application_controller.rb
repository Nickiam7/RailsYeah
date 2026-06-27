class ApplicationController < ActionController::Base
  include Seo::Metadata
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def user_not_authorized
    redirect_to root_path, alert: "You are not authorized to access that page."
  end
end
