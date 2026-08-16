require "test_helper"

class TaskTest < ActiveSupport::TestCase
  test "is valid with title" do
    task = Task.new(title: "Finish homework", completed: false)
    assert task.valid?
  end

  test "is invalid without title" do
    task = Task.new(title: nil, completed: false)
    assert_not task.valid?
    assert_includes task.errors[:title], "can't be blank"
  end

  test "is invalid with blank title" do
    task = Task.new(title: "   ", completed: false)
    assert_not task.valid?
    assert_includes task.errors[:title], "can't be blank"
  end

  test "default completed status is false" do
    task = Task.new(title: "New task")
    assert_equal false, task.completed
  end

  test ".completed scope returns only completed tasks" do
    completed_tasks = Task.completed
    assert completed_tasks.all?(&:completed?)
    assert_includes completed_tasks, tasks(:two)
    assert_not_includes completed_tasks, tasks(:one)
  end

  test ".pending scope returns only pending tasks" do
    pending_tasks = Task.pending
    assert pending_tasks.none?(&:completed?)
    assert_includes pending_tasks, tasks(:one)
    assert_not_includes pending_tasks, tasks(:two)
  end
end
