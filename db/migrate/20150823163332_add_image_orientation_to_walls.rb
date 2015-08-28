class AddImageOrientationToWalls < ActiveRecord::Migration
  def change
    add_column :walls, :image_orientation, :string
  end
end
