class AddWallToIdealBoulderSpread < ActiveRecord::Migration
  def change
    add_reference :ideal_boulder_spreads, :wall, index: true, foreign_key: true
  end
end
