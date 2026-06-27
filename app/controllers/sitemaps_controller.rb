# frozen_string_literal: true

# Serves /sitemap.xml. Inherits ActionController::Base directly (not
# ApplicationController) so this machine-facing endpoint skips the app's
# modern-browser gate. Extend `pages` as the site grows.
class SitemapsController < ActionController::Base
  def show
    @pages = [
      { loc: root_url, changefreq: "weekly", priority: "1.0" }
    ]
  end
end
