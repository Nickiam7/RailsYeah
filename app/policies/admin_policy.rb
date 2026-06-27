# frozen_string_literal: true

# Headless policy guarding access to the admin area. Used as
# `authorize :admin, :access?` in Admin::BaseController.
class AdminPolicy < ApplicationPolicy
  def access?
    user.present? && user.admin?
  end
end
