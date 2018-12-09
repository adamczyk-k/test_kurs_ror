class CreateTrainingCosts < ActiveRecord::Migration[5.2]
  def change
    create_table :training_costs do |t|
      t.references :training, foreign_key: true
      t.references :resource_type, foreign_key: true
      t.integer :cost

      t.timestamps
    end
  end
end
