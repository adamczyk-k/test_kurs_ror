class CreateTrainings < ActiveRecord::Migration[5.2]
  def change
    return if table_exists? :dragon_trainings

    create_table :trainings do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
