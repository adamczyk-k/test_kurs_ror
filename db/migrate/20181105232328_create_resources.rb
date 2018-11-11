class CreateResources < ActiveRecord::Migration[5.2]
  def change
    create_table :resources do |t|
      t.references :user, foreign_key: true
      t.references :resource_type, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
