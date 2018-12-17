class CreateTrainingPrizes < ActiveRecord::Migration[5.2]
  def change
    create_table :training_prizes do |t|
      t.references :training, foreign_key: true
      t.references :attributes_type, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
