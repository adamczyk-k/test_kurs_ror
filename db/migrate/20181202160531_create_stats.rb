class CreateStats < ActiveRecord::Migration[5.2]
  def change
    create_table :stats do |t|
      t.references :dragon, foreign_key: true
      t.integer :strength
      t.integer :perception
      t.integer :luck

      t.timestamps
    end
  end
end
