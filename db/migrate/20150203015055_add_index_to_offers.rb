class AddIndexToOffers < ActiveRecord::Migration
  def change
    add_index :offers, [:user_id, :task_id], :unique => true
  end
end
