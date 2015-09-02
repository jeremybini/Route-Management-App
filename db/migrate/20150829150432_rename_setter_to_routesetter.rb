class RenameSetterToRoutesetter < ActiveRecord::Migration
  def change
  	rename_column :climbs, :setter, :routesetter
  end
end
