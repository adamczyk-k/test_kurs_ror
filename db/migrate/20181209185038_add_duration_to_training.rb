class AddDurationToTraining < ActiveRecord::Migration[5.2]
  def change
    add_column :trainings, :duration, :integer
  end
end
