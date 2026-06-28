# Spike: Sourcing live course data from Udemy (#2950)

**Goal:** stop hardcoding the course stats in `config/initializers/site.rb`
(`Site::RATING`, `RATING_COUNT`, `LECTURES`, `DURATION`, `LEVEL`, `WORKLOAD_ISO`)
— which feed the hero "Course at a glance" card and the JSON-LD `Course` schema —
and instead pull them from a source of truth.

> ⚠️ The Udemy developer docs (`udemy.com/developers/*`) and support pages return
> **403 to automated clients**, so the findings below come from search + public
> mirrors. The exact endpoint paths and JSON field names should be confirmed by
> the implementer once a real bearer token is in hand.

## Findings

### 1. Affiliate API — ❌ discontinued
The Udemy **Affiliate API** (`api-2.0`, the old `GET /courses/{id}/` returning
`avg_rating`, `num_reviews`, `num_subscribers`, `content_info`, …) was the obvious
fit, but **access was discontinued as of 2025-01-01**. Not an option.

### 2. Instructor API — ✅ available, and the right fit
The **Instructor API v1.0** is live (though in "maintenance mode" — operational,
but no new features planned). Because we *are* the course's instructor, this is
the natural source for our own course's data.

- **Auth:** create an API client on the **API Clients** page in the Udemy user
  profile → get a **bearer token** (active immediately, no approval gate like the
  old affiliate program). Sent as `Authorization: bearer {token}`.
- **Base URL:** `https://www.udemy.com/instructor-api/v1/`
- **Endpoints:** the instructor's courses are under `/taught-courses/courses/`,
  with sub-resources for curriculum, reviews, and analytics (course management,
  reviews, curriculum/lectures, performance).
- **Rate limit:** **100 requests / 10 seconds** (429 beyond) — a non-issue for a
  periodic sync.
- **Data we need:** rating + review count (reviews/analytics), lecture count
  (curriculum), total content length / duration, enrollments. Exact field names
  TBD until we hit the API with a token.
- **ToS:** governed by the [Udemy API License Agreement](https://www.udemy.com/terms/api/) —
  review before shipping, though displaying our **own** course's stats on our own
  marketing site is the intended kind of use.

### 3. Udemy for Business API — not applicable
Requires a Udemy Business organization + client id/secret. We're a single
instructor marketing page, so N/A.

### 4. Scraping — fallback only, not recommended
The public course page is a React SPA (stats live in embedded JSON, markup is
unstable), Udemy's ToS discourages scraping, and it'd need ongoing maintenance and
carries legal risk. Given the Instructor API exists for exactly this data, scraping
is not worth it.

## Recommendation

**Use the Instructor API.** It's purpose-built for an instructor reading their own
course data, auth is a simple immediate bearer token, and the rate limit is
irrelevant for a scheduled sync. Scraping stays as a last resort only.

Caveats to carry into the implementation story:
- It's in maintenance mode (stable, but don't expect new fields).
- The docs are gated, so **step 1 of implementation is: generate a token and
  confirm the real endpoints + field names** for rating / reviews / lecture count
  / content length.

## Proposed implementation (follow-up story)

- **Token** in `config/credentials.yml.enc` (`udemy: api_token:`), per our secrets
  convention.
- **`Udemy::Client`** — small wrapper (Net::HTTP/Faraday) with bearer auth, JSON
  parsing, timeouts, and error handling.
- **Scheduled sync** via Solid Queue (already in the app) — daily/weekly recurring
  job that fetches the metrics and writes them to a store: either the editable
  content model from #2944 (preferred — pairs with the Content Management epic) or
  a small `CourseStats` record / `Rails.cache`.
- **Fallback:** on any fetch error, keep the last good values; if none, fall back to
  the current `Site::*` constants. The hero + JSON-LD read from the synced store.
- **Tests:** client against stubbed responses, the job, and the fallback path.

**Rough effort:** ~1.5–2 days (≈3–5 pts): explore the API (~½ day), client + job +
storage + fallback (~1 day), wire hero/JSON-LD + tests (~½ day). Best done
alongside #2944 so the synced values land in a content model.

## Sources

- [Affiliate API v2.0 Reference (discontinued)](https://www.udemy.com/developers/affiliate/)
- [Instructor API v1.0 Reference](https://www.udemy.com/developers/instructor/)
- [Udemy API Documentation Home](https://www.udemy.com/developers/)
- [Udemy API License Agreement](https://www.udemy.com/terms/api/)
