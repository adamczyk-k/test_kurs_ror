class CreateAttributesTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :attributes_types do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
