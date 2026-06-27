# frozen_string_literal: true

# Serves /robots.txt dynamically so the Sitemap line always points at the current
# host (no hardcoded domain). Machine-facing, so it skips the app's browser gate.
class RobotsController < ActionController::Base
  def show
    body = [
      "User-agent: *",
      "Allow: /",
      "",
      "Sitemap: #{sitemap_url}"
    ].join("\n")

    render plain: "#{body}\n", content_type: "text/plain"
  end
end
