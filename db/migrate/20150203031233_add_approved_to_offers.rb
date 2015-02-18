class AddApprovedToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :approved, :boolean, default: false, null: false
    add_column :offers, :completed, :boolean, default: false, null: false
  end
end
