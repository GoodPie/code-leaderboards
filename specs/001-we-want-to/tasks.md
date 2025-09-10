# Tasks: Visually Appealing Landing Page

**Input**: Design documents from `/specs/001-we-want-to/`
**Prerequisites**: plan.md (required), research.md, data-model.md, quickstart.md

## Execution Flow (main)

```
1. Load plan.md from feature directory
   → If not found: ERROR "No implementation plan found"
   → Extract: tech stack, libraries, structure
2. Load optional design documents:
   → data-model.md: Extract entities → model tasks
   → contracts/: Each file → contract test task
   → research.md: Extract decisions → setup tasks
3. Generate tasks by category:
   → Setup: project init, dependencies, linting
   → Tests: contract tests, integration tests
   → Core: models, services, CLI commands
   → Integration: DB, middleware, logging
   → Polish: unit tests, performance, docs
4. Apply task rules:
   → Different files = mark [P] for parallel
   → Same file = sequential (no [P])
   → Tests before implementation (TDD)
5. Number tasks sequentially (T001, T002...)
6. Generate dependency graph
7. Create parallel execution examples
8. Validate task completeness:
   → All contracts have tests?
   → All entities have models?
   → All endpoints implemented?
9. Return: SUCCESS (tasks ready for execution)
```

## Format: `[ID] [P?] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- Include exact file paths in descriptions

## Path Conventions

- **Web app**: `app/`, `config/`, `test/` at repository root
- Paths shown below assume web app structure

## Phase 3.1: Setup

- [ ] T001 Create a new route for the landing page in `config/routes.rb`.

## Phase 3.2: Tests First (TDD) ⚠️ MUST COMPLETE BEFORE 3.3

**CRITICAL: These tests MUST be written and MUST FAIL before ANY implementation**

- [ ] T002 [P] Create a system test for the landing page in `test/system/landing_page_test.rb`.

## Phase 3.3: Core Implementation (ONLY after tests are failing)

- [ ] T003 Create a new controller for the landing page in `app/controllers/landing_page_controller.rb`.
- [ ] T004 Create the view for the landing page in `app/views/landing_page/index.html.erb`.

## Phase 3.4: Polish

- [ ] T005 [P] Style the landing page using Tailwind CSS in `app/views/landing_page/index.html.erb` and
  `app/assets/stylesheets/application.tailwind.css`.

## Dependencies

- T001 (Route) must be completed before T003 (Controller).
- T002 (System Test) must be completed before T003 (Controller) and T004 (View).
- T003 (Controller) must be completed before T004 (View).

## Parallel Example

- T002 and T005 can be worked on in parallel after their dependencies are met.

```
# Launch T002 and T005 together:
Task: "Create a system test for the landing page in test/system/landing_page_test.rb"
Task: "Style the landing page using Tailwind CSS in app/views/landing_page/index.html.erb and app/assets/stylesheets/application.tailwind.css"
```

## Notes

- [P] tasks = different files, no dependencies
- Verify tests fail before implementing
- Commit after each task
- Avoid: vague tasks, same file conflicts

## Task Generation Rules

*Applied during main() execution*

1. **From Contracts**:
    - Each contract file → contract test task [P]
    - Each endpoint → implementation task

2. **From Data Model**:
    - Each entity → model creation task [P]
    - Relationships → service layer tasks

3. **From User Stories**:
    - Each story → integration test [P]
    - Quickstart scenarios → validation tasks

4. **Ordering**:
    - Setup → Tests → Models → Services → Endpoints → Polish
    - Dependencies block parallel execution

## Validation Checklist

*GATE: Checked by main() before returning*

- [ ] All contracts have corresponding tests
- [ ] Contract tests assert request/response schemas and enumerate failure modes
- [ ] All entities have model tasks
- [ ] All tests come before implementation
- [ ] Parallel tasks truly independent
- [ ] Each task specifies exact file path
- [ ] No task modifies same file as another [P] task

---
*Based on Constitution v1.0.0 (Ratified: 2025-09-10) - See `/memory/constitution.md`*