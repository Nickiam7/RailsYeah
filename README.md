# Udemy Course Landing Page

Marketing landing page for the Udemy course
[**Ruby on Rails 8 and Hotwire: Build a Password Manager**](https://www.udemy.com/course/ruby-on-rails-8-and-hotwire-build-a-password-manager/).
The goal is an SEO-friendly site that drives traffic to the course (with room to grow
into a full learning experience later).

> The internal app/module is named `RailsYeah` (database `rails_yeah_*`).

## Stack

- **Ruby** 3.4.3 / **Rails** 8.0.5
- **Database:** PostgreSQL
- **Assets (no build step):** [Propshaft](https://github.com/rails/propshaft) +
  [import maps](https://github.com/rails/importmap-rails) — no Node bundler for JS or CSS
- **UI:** [Bootstrap](https://getbootstrap.com/) 5.3.x, vendored locally (no CDN, no build)
- **Hotwire:** Turbo + Stimulus

## Getting started

Requires Ruby 3.4.3 and a running PostgreSQL server.

```bash
bundle install
bin/rails db:create
bin/rails db:migrate   # no migrations yet, but safe to run
bin/rails server
```

Then open http://localhost:3000 — the placeholder home page renders a Bootstrap
alert and dropdown to confirm the CSS and JS are wired up. (This page is replaced by
the real landing shell in a later story.)

## How Bootstrap is vendored (no build)

Bootstrap ships as local assets so it loads with zero build tooling:

- **JS** is pinned and downloaded into `vendor/javascript/` via import maps, then
  imported in `app/javascript/application.js` (`import "bootstrap"`):

  ```bash
  bin/importmap pin bootstrap @popperjs/core
  ```

  In importmap-rails 2.x, `pin` downloads/vendors by default (the old `--download`
  flag is gone). Pins live in `config/importmap.rb`.

- **CSS** is the compiled `bootstrap.min.css` placed directly in
  `app/assets/stylesheets/` and linked in `app/views/layouts/application.html.erb`:

  ```erb
  <%= stylesheet_link_tag "bootstrap.min", "data-turbo-track": "reload" %>
  ```

  To update the CSS, re-download the matching version into `app/assets/stylesheets/`:

  ```bash
  curl -o app/assets/stylesheets/bootstrap.min.css \
    https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css
  ```

  Keep the CSS version in sync with the pinned JS version.

## Configuration

- Database config: `config/database.yml` (dev/test/prod).
- Production DB password is read from `RAILS_YEAH_DATABASE_PASSWORD`.

## Tests

```bash
bin/rails test
```
