class RenameRoutesToClimbs < ActiveRecord::Migration
  def change
  	rename_table :routes, :climbs
  end
end
