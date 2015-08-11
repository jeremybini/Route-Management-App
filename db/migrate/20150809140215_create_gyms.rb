class CreateGyms < ActiveRecord::Migration
  def change
    create_table :gyms do |t|
      t.string :name
      t.string :location
      t.float :latitude
      t.float :longitude
      t.string :gym_image

      t.timestamps null: false
    end
  end
end
