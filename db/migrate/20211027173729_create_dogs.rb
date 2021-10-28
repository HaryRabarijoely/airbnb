class CreateDogs < ActiveRecord::Migration[5.2]
  def change
    create_table :dogs do |t|
      t.string :name
      t.string :age
      t.string :breed
      t.string :gender
      t.string :size
      t.string :sound
      t.string :favorite_food
      t.belongs_to :city, index: true

      t.timestamps
    end
  end
end
