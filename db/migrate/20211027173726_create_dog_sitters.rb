class CreateDogSitters < ActiveRecord::Migration[5.2]
  def change
    create_table :dog_sitters do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :email
      t.integer :age
      t.string :gender
      t.string :favorite_movie
      t.string :favorite_band
      t.string :favorite_beer
      t.text :bio
      t.belongs_to :city, index: true

      t.timestamps
    end
  end
end
