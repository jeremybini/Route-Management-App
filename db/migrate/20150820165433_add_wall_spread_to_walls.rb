class AddWallSpreadToWalls < ActiveRecord::Migration
  def change
    add_column :walls, :wall_spread, :text
  end
end
