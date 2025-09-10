# Code Challenge Platform (for Meetup Groups)

An open-source web app to run coding challenges for meetup groups (starting with Ruby Perth). Organizers can post
problems; members can submit solutions, discuss approaches, and learn together.

This README is an initial outline plus a minimal “Getting Started” guide, including Supabase setup. We’ll iterate as the
project grows.

## Goals (MVP)

- Organizers:
    - Create and publish code challenges (title, prompt, tags, optional starter code).
- Members:
    - Submit solutions (code + explanation).
    - Comment on and discuss solutions.
- Browsing:
    - List challenges, filter by tags, view individual challenge pages.
- Simple moderation:
    - Organizers can hide/remove inappropriate content.

## Tech Stack

- Backend: Ruby on Rails 8 (Ruby 3.4.2)
- DB: PostgreSQL (via Supabase managed Postgres)
- Auth: Rails 8 auth generator (see https://guides.rubyonrails.org/security.html)
- Frontend: Turbo + Stimulus, Tailwind CSS
- Jobs/Cache: Solid Queue / Solid Cache (Rails defaults)
- Web server: Puma
- Package managers: bundler (Ruby), bun (Bun)
- Dev speedups: bootsnap, debug, web-console
- Testing (planned): RSpec/Capybara or Rails default test framework

## High-Level Architecture (MVP)

- Challenges: posted by organizers.
- Solutions: submitted by members, associated with a challenge and a user.
- Comments: threaded discussion on solutions (and possibly challenges).
- Users: handled by Supabase Auth; Rails app uses Supabase JWT to identify users.
- Roles: organizer vs member (basic authorization via cancancan).

## Roadmap (Short-Term)

- Connect Rails to Supabase Postgres (DATABASE_URL).
- Authentication utilises Rails 8 auth generator (https://guides.rubyonrails.org/security.html)
- Basic CRUD for challenges, solutions, and comments.
- Authorisation with cancancan.
- Minimal Tailwind styling.
- Seed data for local dev.

## Getting Started

### Prerequisites

- asdf (recommended for managing Ruby/Node versions)
- Ruby 3.4.2 (via asdf)
- Node.js (current LTS) + npm
- Git
- Supabase account (free tier is fine) for CLI

### 1) Clone and install dependencies

```shell script
# Using HTTPS
git clone <YOUR_REPO_URL> meetup-code-challenges
cd meetup-code-challenges

# asdf (recommended)
asdf install

# Ruby gems
bundle install

# JS packages
bun install
```

### 2) Create a Supabase project

- Go to https://supabase.com and create a new project.
- Note:
    - Project URL (SUPABASE_URL)
    - anon public API key (SUPABASE_ANON_KEY)
    - service role key (SUPABASE_SERVICE_ROLE_KEY, server-side only; keep secret!)
- In the project’s Database settings, find the connection string (Postgres). This will be used as your Rails
  DATABASE_URL.

Tip: Supabase provides a managed Postgres instance; we’ll use that as our app database to keep local setup simple and
keep parity with production.

### 3) Configure environment

Create a .env file (or use Rails credentials if you prefer). For simplicity, we’ll use .env during development:

```shell script
cp .env.example .env
```

Edit .env and fill in:

```shell script
# Rails
RAILS_ENV=development
PORT=3001

# Database (use Supabase's Postgres connection string)
DATABASE_URL=postgres://<user>:<password>@<host>:<port>/<db>?sslmode=require

# Supabase
SUPABASE_URL=https://<your-project-ref>.supabase.co
SUPABASE_ANON_KEY=<anon-public-key>
SUPABASE_SERVICE_ROLE_KEY=<service-role-key>  # Do not expose client-side
SUPABASE_JWT_AUD=authenticated                # default in many setups
SUPABASE_JWT_ISS=https://<your-project-ref>.supabase.co/auth/v1
```

Notes:

- sslmode=require is often needed for Supabase remote connections.
- Do not expose the service role key in the browser; only used server-side.

Optional: If you prefer not to use .env, set these via your shell or use Rails credentials.

### 4) Prepare the database

```shell script
bin/rails db:prepare
# Optionally seed data
bin/rails db:seed
```

### 5) Run the app

```shell script
# Rails 8 has bin/dev if set up with CSS/JS bundling
bin/dev
# Or:
bin/rails server
```

App will be available at http://localhost:3001.

## Supabase Auth (Planned Integration)

- Client side: users sign in via Supabase (email magic link or OAuth providers).
- The browser stores a Supabase session; requests include a JWT.
- Server side (Rails):
    - Verify JWT on each request (before_action).
    - Create/find the corresponding User record by sub (Supabase user id).
    - Assign roles (organizer/member) via a role column and manage with cancancan.

This will be fleshed out with helpers and middleware. For early development, we may use a simple “dev sign-in” toggle or
seeds.

## Development Commands

- Lint (Ruby): bundle exec rubocop
- Lint (Rails Omakase defaults): bundle exec rubocop -D
- Brakeman: bundle exec brakeman
- Run tests: bin/rails test (or RSpec if added later)
- Tailwind build: handled by bin/dev via tailwindcss-rails/jsbundling

## Project Conventions

- Ruby/Rails style: rubocop-rails-omakase
- Authorization: cancancan abilities in app/models/ability.rb
- Background jobs: solid_queue (configure later as needed)
- Caching: solid_cache
- Frontend: Turbo/Stimulus, minimal custom JS

## Contributing

- Open an issue or discussion to propose features/changes.
- For PRs:
    - Create a topic branch.
    - Add/adjust tests where relevant.
    - Ensure lint passes.
    - Keep changes small and focused.

## License

TBD (suggestion: MIT)

## Acknowledgements

- Rails, Supabase, and the broader OSS ecosystem.

