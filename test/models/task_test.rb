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
end
