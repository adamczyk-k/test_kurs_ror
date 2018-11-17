class CreateExpeditionPrizes < ActiveRecord::Migration[5.2]
  def change
    create_table :expedition_prizes do |t|
      t.string :name
      t.integer :prize
      t.references :expedition_type, foreign_key: true
      t.references :resource_type, foreign_key: true

      t.timestamps
    end
  end
end
