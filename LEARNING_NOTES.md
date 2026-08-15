# TodoList Learning Notes

This note summarizes what was changed to make the app usable as a basic Todo List.

## 1) Routing
- Added root route so opening `/` shows the task list.
- Kept RESTful routes for tasks.

File changed:
- `config/routes.rb`

Why:
- Users should land on a meaningful page immediately.

## 2) Tasks Controller (CRUD)
Implemented full CRUD actions:
- `index` loads all tasks and prepares a new task form object.
- `show` displays one task.
- `new` and `edit` render forms.
- `create` saves a new task and handles validation errors.
- `update` updates title/completed state and handles validation errors.
- `destroy` deletes a task.

Also added private helpers:
- `set_task` to find records safely for member actions.
- `task_params` to enforce strong parameters.

File changed:
- `app/controllers/tasks_controller.rb`

Why:
- `resources :tasks` in routes expects CRUD behavior.

## 3) Views
Replaced placeholder content with real task UI:
- Index now has create form, list of tasks, complete toggle, edit and delete actions.
- Added shared form partial for reusable form logic and error display.
- Added `new`, `edit`, and `show` pages.

Files changed:
- `app/views/tasks/index.html.erb`
- `app/views/tasks/_form.html.erb`
- `app/views/tasks/new.html.erb`
- `app/views/tasks/edit.html.erb`
- `app/views/tasks/show.html.erb`

Why:
- UI was scaffold placeholder and had broken product code mixed into tasks page.

## 4) Migration Fix
Removed invalid model-like validation code from migration.

File changed:
- `db/migrate/20260815082637_create_tasks.rb`

Why:
- Validations belong in models, not migrations.
- This prevents failures when running migrations in a fresh environment.

## 5) Feedback Messages
Added flash display to application layout for `notice` and `alert`.

File changed:
- `app/views/layouts/application.html.erb`

Why:
- Users can see results of create/update/delete actions.

## 6) Tests Added
Controller tests now cover:
- index/new/show/edit pages
- create success and create validation failure
- update
- destroy

Model tests now cover:
- valid when title exists
- invalid when title is blank

Fixture data improved to represent realistic task states.

Files changed:
- `test/controllers/tasks_controller_test.rb`
- `test/models/task_test.rb`
- `test/fixtures/tasks.yml`

Why:
- Prevent regressions and document expected behavior.

## Concepts to remember
- Migrations define database structure.
- Models define business rules/validations.
- Controllers coordinate HTTP request/response flow.
- Views render HTML.
- Tests lock in behavior so refactoring is safer.

## Useful commands
- Run app: `bin/rails server`
- Run all tests: `bin/rails test`
- Run one test file: `bin/rails test test/controllers/tasks_controller_test.rb`
