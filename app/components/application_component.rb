# frozen_string_literal: true

# Base class for all ViewComponents in this app. Shared helpers and conventions
# live here. New components inherit from it automatically (the generator picks up
# ApplicationComponent as the parent when it is defined).
class ApplicationComponent < ViewComponent::Base
end
