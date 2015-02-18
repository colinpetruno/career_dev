class AddAcceptedToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :accepted, :boolean, default: false, null: false
  end
end
