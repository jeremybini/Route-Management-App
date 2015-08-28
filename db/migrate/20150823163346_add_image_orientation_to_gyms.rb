class AddImageOrientationToGyms < ActiveRecord::Migration
  def change
    add_column :gyms, :image_orientation, :string
  end
end
