# frozen_string_literal: true

# Preview at /rails/view_components/sections/learn_component
class Sections::LearnComponentPreview < ViewComponent::Preview
  def default
    objectives = [
      "Build a single-codebase Rails app that serves a web UI and a secure JSON API",
      "Create a secure JSON API with JWT authentication",
      "Use Hotwire (Turbo and Stimulus) to build an SPA-like experience",
      "Build a Google Chrome extension that consumes the JSON API",
      "Encrypt sensitive data with Active Record encryption",
      "Deploy a production Rails 8 application"
    ].map { |description| LearningObjective.new(description: description) }

    render(Sections::LearnComponent.new(objectives: objectives))
  end
end
