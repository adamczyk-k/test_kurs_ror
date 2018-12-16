class CreateDragonTombstones < ActiveRecord::Migration[5.2]
  def change
    create_table :dragon_tombstones do |t|
      t.string :name
      t.references :user, foreign_key: true
      t.references :dragon_type, foreign_key: true
      t.integer :level
      t.text :cause_of_death

      t.timestamps
    end
  end
end
