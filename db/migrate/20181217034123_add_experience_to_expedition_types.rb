class AddExperienceToExpeditionTypes < ActiveRecord::Migration[5.2]
  def change
    add_column :expedition_types, :experience, :integer, default: 0
  end
end
