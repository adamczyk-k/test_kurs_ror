class CreateDragonTrainings < ActiveRecord::Migration[5.2]
  def change
    create_table :dragon_trainings do |t|
      t.references :dragon, foreign_key: true
      t.references :training, foreign_key: true
      t.datetime :start_time

      t.timestamps
    end
  end
end
