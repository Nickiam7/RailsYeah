require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsYeah
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # ViewComponent — see the "ViewComponent conventions" section of the README.
    # Every component is namespaced so it gets its own folder under app/components/
    # (e.g. Heading::HeadingComponent -> app/components/heading/heading_component.rb,
    # with its template and preview alongside). Generate with:
    #   bin/rails generate view_component:component Namespace::Name [attrs]
    config.view_component.generate.preview = true   # scaffold a preview with each component
    config.view_component.generate.sidecar = false  # template sits beside the .rb; namespacing already gives each component its own folder
    # Previews are enabled in development/test by default and discovered in
    # test/components/previews, served at /rails/view_components.
    # Render previews in a layout that loads Bootstrap + the theme overlay so
    # components preview with the real site styling.
    config.view_component.previews.default_layout = "component_preview"
  end
end
