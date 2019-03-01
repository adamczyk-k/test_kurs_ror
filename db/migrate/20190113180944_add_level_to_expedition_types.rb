class AddLevelToExpeditionTypes < ActiveRecord::Migration[5.2]
  def change
    add_column :expedition_types, :user_level, :integer, default: 0
    add_column :expedition_types, :dragon_level, :integer, default: 0
  end
end
