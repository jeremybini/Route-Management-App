class RenameRoutesettertoSetterName < ActiveRecord::Migration
  def change
  	rename_column :climbs, :routesetter, :setter_name
  end
end
