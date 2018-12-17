class CreateDragonAttributes < ActiveRecord::Migration[5.2]
  def change
    create_table :dragon_attributes do |t|
      t.references :dragon, foreign_key: true
      t.references :attributes_type, foreign_key: true
      t.integer :level

      t.timestamps
    end
  end
end
