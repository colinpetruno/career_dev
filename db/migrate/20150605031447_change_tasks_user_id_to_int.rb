class ChangeTasksUserIdToInt < ActiveRecord::Migration
  def up
    connection.execute(%q{
      alter table tasks
      alter column user_id
      type integer using cast(user_id as integer)
    })
  end

  def down

  end
end
