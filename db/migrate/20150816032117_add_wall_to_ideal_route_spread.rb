class AddWallToIdealRouteSpread < ActiveRecord::Migration
  def change
    add_reference :ideal_route_spreads, :wall, index: true, foreign_key: true
  end
end
