class RemoveLevelFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :level, :integer
  end
end
