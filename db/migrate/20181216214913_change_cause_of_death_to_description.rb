class ChangeCauseOfDeathToDescription < ActiveRecord::Migration[5.2]
  def change
    rename_column :dragon_tombstones, :cause_of_death, :description
  end
end
