class CreateFundingInstruments < ActiveRecord::Migration
  def change
    create_table :funding_instruments do |t|
      t.string :url
      t.references :company
      t.string :type
      t.timestamps
    end
  end
end
