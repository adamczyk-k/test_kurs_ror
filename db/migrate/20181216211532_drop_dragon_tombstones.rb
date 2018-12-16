class DropDragonTombstone < ActiveRecord::Migration[5.2]
  def change
    create_table :dragon_tombstones do |t|
      t.string :name
      t.references :user, foreign_key: true
      t.references :dragon_type, foreign_key: true
      t.integer :level
      t.text :description

      t.timestamps
    end
  end
end
