# frozen_string_literal: true

module Admin
  # Base controller for the admin area: requires an authenticated admin user.
  # Everything under Admin:: inherits these guards. The dashboard UI + admin
  # layout are built out in #2943.
  class BaseController < ApplicationController
    layout "admin"

    before_action :authenticate_user!
    before_action :require_admin

    private

    def require_admin
      authorize :admin, :access?
    end
  end
end
