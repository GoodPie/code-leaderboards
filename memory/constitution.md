# Web Constitution

## Core Principles

### I. Spec-First (NON-NEGOTIABLE)

All work begins with an executable specification. Write or update tests/specs to express desired behavior before
implementation. Follow a strict Red-Green-Refactor cycle. Specifications must be business-readable where possible and
live alongside the code they validate.

### II. Library-First Design

Prefer extracting cohesive functionality into small, self-contained libraries or components with clear boundaries. Each
unit must be independently testable, documented, and have a well-defined purpose. Avoid creating organizational-only
modules without runtime value.

### III. Contracted Interfaces

All public interfaces (Ruby APIs, background jobs, HTTP endpoints, CLI tasks) require explicit contracts:

- Input/output schemas, failure modes, and side effects documented.
- Backwards compatibility is not relevant. This is a greenfield project.
- Where applicable, provide a simple CLI or rake entrypoint for black-box testing.

### IV. Integration Coverage Where It Matters

Provide integration and system tests for:

- Cross-component flows (e.g., web requests through controllers/views, Turbo/Stimulus interactions).
- Background job orchestration (Solid Queue), caching (Solid Cache), and real-time channels (Solid Cable/Turbo Streams).
- Contract boundaries and shared schemas (e.g., JSON payloads).
  Minimise end-to-end breadth in favour of targeted integration at risk points.

### V. Observability, Versioning, and Simplicity

- Observability: Prefer text I/O for tools, structured logs for services, and minimal, actionable metrics.
- Versioning: Use Semantic Versioning for libraries and documented versioning for APIs/contracts. Breaking changes
  require a deprecation path.
- Simplicity: Choose the simplest design that satisfies the spec. Avoid premature abstractions (YAGNI).

## Platform & Constraints

- Runtime/Tooling:
    - Ruby 3.4.2 (asdf-managed), Rails 8.x, Puma.
    - Node via npm; Tailwind CSS v4 for styling.
- Libraries in active use:
    - App/runtime: pg, turbo-rails, stimulus-rails, tailwindcss-rails, propshaft.
    - Jobs/infra: solid_queue, solid_cache, solid_cable.
    - Dev/test: capybara, selenium-webdriver, factory_bot_rails, debug, web-console.
    - Quality: rubocop-rails-omakase, brakeman, bootsnap.
- Security & Quality Gates:
    - Brakeman must pass without new warnings; security issues are blockers.
    - RuboCop Omakase rules enforced; deviations require inline justification and a follow-up issue.
    - Dependencies are pinned; updates require changelog review and, for risky updates, a canary plan.
- Performance & Reliability:
    - Database queries measured in critical paths; N+1 avoided with tests where feasible.
    - Cache usage (Solid Cache) must include invalidation strategy in docs.
    - Background jobs idempotent and retry-safe; clearly document retry policy and dead-letter handling.

## Development Workflow

- Spec-First Flow:
    1. Create/adjust specs to capture the user-visible change or bug.
    2. Ensure specs fail for the right reason (Red).
    3. Implement minimal code to pass (Green).
    4. Refactor with tests green and lints clean (Refactor).
- Testing Standards:
    - Use Rails’ default test framework with Capybara for system flows.
    - Prefer request/system tests for user value, model tests for domain logic, and contract tests for public
      interfaces.
    - Factories via factory_bot; avoid fixtures for new tests.
- Code Review:
    - Every PR requires review by at least one maintainer.
    - Reviewers verify: spec-first evidence, contract stability, observability hooks, security impact, and adherence to
      style.
- CI/CD:
    - CI runs: tests, RuboCop, Brakeman, and minimal build steps (JS/CSS).
    - A PR cannot merge if any gate fails or coverage meaningfully decreases in changed areas.
    - Deploys require green main and no outstanding security blockers.
- Documentation:
    - Public interfaces must include usage examples and failure modes.
    - Changes affecting users or operators require updating README/CHANGELOG and any runbooks.

## Governance

- This Constitution supersedes conflicting team practices and docs.
- Amendments:
    - Must be proposed via PR with rationale, migration plan (if applicable), and examples.
    - Require approval from two maintainers or one maintainer plus a domain owner.
    - Breaking process changes mandate a minor version bump of this document.
- Compliance:
    - PR templates include a checklist referencing this Constitution.
    - Exceptions are temporary, must be explicitly labeled in-code with justification and an issue link, and reviewed in
      the next planning cycle.

Version: 1.0.0 | Ratified: 2025-09-10 | Last Amended: 2025-09-10