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
- **Components:** [ViewComponent](https://viewcomponent.org) (sidecar + namespaced — see below)
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

## ViewComponent conventions

UI is built with [ViewComponent](https://viewcomponent.org).

> **Convention: wrap Bootstrap UI in ViewComponents.** Almost every element —
> including Bootstrap pieces (buttons, cards, navbars, alerts, …) — should be a
> ViewComponent rather than raw markup repeated across views. Components own their
> Bootstrap classes and any Stimulus behavior, so markup stays DRY and testable.
> (The placeholder `pages#home` is the one exception while the landing shell is
> still being built.)

**Sidecar + namespacing.** Every component is **namespaced** so it gets its own
folder under `app/components/`, with the Ruby class, template, and (in tests) the
preview kept together:

```
app/components/
  application_component.rb            # base class all components inherit from
  heading/
    heading_component.rb              # class Heading::HeadingComponent
    heading_component.html.erb        # template, beside the .rb
test/components/
  heading/heading_component_test.rb
  previews/heading/heading_component_preview.rb
```

Generate a component with the namespaced name (the generator appends `Component`):

```bash
bin/rails generate view_component:component Heading::Heading title
#   create app/components/heading/heading_component.rb        -> Heading::HeadingComponent
#   create app/components/heading/heading_component.html.erb
#   create test/components/previews/heading/heading_component_preview.rb
#   create test/components/heading/heading_component_test.rb
```

Defaults are set in `config/application.rb`:

- `config.view_component.generate.sidecar = false` — namespacing already gives each
  component its own folder, so the template sits **beside** the `.rb`. Flip this to
  `true` if you'd rather nest the template in a `heading_component/` subfolder.
- `config.view_component.generate.preview = true` — scaffolds a preview per component.

Render a component in any view:

```erb
<%= render Heading::HeadingComponent.new(title: "Welcome", subtitle: "...", align: "center") %>
```

**Previews.** Enabled in development/test and served at
[`/rails/view_components`](http://localhost:3000/rails/view_components). Preview
classes live in `test/components/previews/`.

## Hotwire (Turbo + Stimulus)

JavaScript behavior uses [Hotwire](https://hotwired.dev) — no bundler. Everything
loads through the import map (see "Bootstrap (no build)" above); entry point is
`app/javascript/application.js`.

- **Turbo** (`turbo-rails`) is imported and enabled app-wide (Turbo Drive on by
  default). Bootstrap's CSS is tagged `data-turbo-track="reload"` so a new
  deploy's assets are picked up across Turbo visits.
- **Stimulus** controllers live in `app/javascript/controllers/`. They are
  auto-registered by filename via `eagerLoadControllersFrom` in
  `controllers/index.js`, so `foo_controller.js` becomes the `foo` identifier — no
  manual registration needed.

Add a controller:

```bash
bin/rails generate stimulus foo   # -> app/javascript/controllers/foo_controller.js
```

Reference it from a component or view with `data-controller`, `data-action`, and
`data-<name>-target`. The sample `Counter::CounterComponent`
(`app/components/counter/`) wires a Bootstrap button to
`app/javascript/controllers/counter_controller.js` and is exercised by a browser
system test (`test/system/hotwire_test.rb`) that confirms Stimulus fires and Turbo
is loaded.

## Authentication (admin only)

The CMS is admin-only — there is **no public sign-up** (Devise's `:registerable`
is disabled). The first admin is created by the seeds:

```bash
bin/rails db:seed   # creates the admin user
```

Sign in at `/users/sign_in`.

**Secrets live in Rails encrypted credentials** (`config/credentials.yml.enc`,
decrypted by `config/master.key` locally or `RAILS_MASTER_KEY` in production) —
not raw env vars. Edit them with:

```bash
bin/rails credentials:edit
```

```yaml
admin:
  email: admin@yourdomain.com
  password: <a-strong-password>     # required in production
postmark:
  api_token: <postmark-server-token>
mailer:
  sender: no-reply@yourdomain.com   # verified Postmark sender
app:
  host: yourdomain.com              # host for mailer links
database:
  password: <production-db-password>
```

Dev/test fall back to safe defaults (admin `admin@example.com` / `password123456`),
so you can run locally without setting anything. **Production requires the admin
credential** — `db:seed` raises if it's missing — plus the Postmark token for mail.
The only env var a production host needs is `RAILS_MASTER_KEY` (the rest is in the
encrypted store).

## Configuration

- Database config: `config/database.yml` (dev/test/prod).
- Production DB password is read from `RAILS_YEAH_DATABASE_PASSWORD`.

## Tests

```bash
bin/rails test
```
