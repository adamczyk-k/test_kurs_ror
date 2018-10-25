class CreateDragonTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :dragon_types do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
