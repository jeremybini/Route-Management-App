class AddImageOrientationToClimbs < ActiveRecord::Migration
  def change
    add_column :climbs, :image_orientation, :string
  end
end
