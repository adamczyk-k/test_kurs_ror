class AddTimeToExpeditions < ActiveRecord::Migration[5.2]
  def change
    add_column :expeditions, :start_time, :datetime
  end
end
