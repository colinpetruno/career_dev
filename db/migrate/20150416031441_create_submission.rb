class CreateSubmission < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.references :offer
      t.text :feedback

      t.timestamps
    end
  end
end
