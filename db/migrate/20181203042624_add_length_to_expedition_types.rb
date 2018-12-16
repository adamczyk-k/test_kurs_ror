class AddLengthToExpeditionTypes < ActiveRecord::Migration[5.2]
  def change
    add_column :expedition_types, :longevity, :integer, default: 0
  end
end
