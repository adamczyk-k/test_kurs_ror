class CreateFoodTimes < ActiveRecord::Migration[5.2]
  def change
    create_table :food_times do |t|
      t.references :dragon, foreign_key: true
      t.datetime :time

      t.timestamps
    end
  end
end
