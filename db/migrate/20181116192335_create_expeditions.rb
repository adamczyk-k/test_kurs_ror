class CreateExpeditions < ActiveRecord::Migration[5.2]
  def change
    create_table :expeditions do |t|
      t.references :user, foreign_key: true
      t.references :dragon, foreign_key: true
      t.references :expedition_type, foreign_key: true

      t.timestamps
    end
  end
end
