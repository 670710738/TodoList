class NormalizeTasksCompletedStatus < ActiveRecord::Migration[8.1]
  def up
    execute "UPDATE tasks SET completed = 0 WHERE completed IS NULL"
    change_column_default :tasks, :completed, from: nil, to: false
    change_column_null :tasks, :completed, false
  end

  def down
    change_column_null :tasks, :completed, true
    change_column_default :tasks, :completed, from: false, to: nil
  end
end
