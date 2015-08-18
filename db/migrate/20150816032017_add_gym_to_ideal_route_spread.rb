class AddGymToIdealRouteSpread < ActiveRecord::Migration
  def change
    add_reference :ideal_route_spreads, :gym, index: true, foreign_key: true
  end
end
