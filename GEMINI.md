# Project Overview

This is a Ruby on Rails application designed to be a code challenge platform for meetup groups. Organizers can post
problems, and members can submit solutions, discuss approaches, and learn together.

**Main Technologies:**

* **Backend:** Ruby on Rails 8.0.2.1 (Ruby 3.4.2)
* **Database:** PostgreSQL
* **Frontend:** Hotwire (Turbo, Stimulus), Tailwind CSS v4
* **JavaScript Bundling:** bun
* **Authentication:** Native Rails 8 authentication
* **Authorization:** cancancan
* **Deployment:** Docker, Kamal

**Architecture:**

The project follows a standard Ruby on Rails MVC architecture.

* **Models:** Located in `app/models`, define the application's data structure and business logic.
* **Views:** Located in `app/views`, are responsible for rendering the UI. They use ERB templates and Tailwind CSS for
  styling.
* **Controllers:** Located in `app/controllers`, handle user requests, interact with models, and render views.

# Building and Running

**1. Install Dependencies:**

* **Ruby:** `bundle install`
* **JavaScript:** `bun install`

**2. Database Setup:**

* The application is configured to use a PostgreSQL database. The configuration is in `config/database.yml`.
* To create and migrate the database, run: `rails db:prepare`

**3. Running the Application:**

* To run the development server, use: `bin/dev`
* This will start the Rails server, and the JavaScript and CSS watchers.
* The application will be available at `http://localhost:3001`.

**4. Running Tests:**

* The project uses the default Rails testing framework (Minitest).
* To run the test suite, use: `rails test`

# Development Conventions

* **Coding Style:** The project uses `rubocop-rails-omakase` for Ruby code styling. The configuration is in
  `.rubocop.yml`.
* **Authentication:** The application uses the built-in Rails 8 authentication. The `ApplicationController` includes the
  `Authentication` concern.
* **Authorization:** Authorization is handled by the `cancancan` gem. Abilities are defined in `app/models/ability.rb`.
* **Frontend:** The frontend is built with Hotwire (Turbo and Stimulus) and styled with Tailwind CSS. JavaScript is
  bundled with `bun`.
* **Deployment:** The application is set up for deployment with Docker and Kamal. The `Dockerfile` and
  `config/deploy.yml` contain the deployment configuration.

## Gemini Added Memories

- We are using Tailwind CSS 4.1. Consult documentation for Tailwind 4.1 for any changes made to the core files and make
  sure we are following up to date documentation. Do not create a tailwind.config.js (this means we are not following
  latest documentation)