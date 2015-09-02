class AddSetterIdToClimb < ActiveRecord::Migration
  def change
  	add_column :climbs, :setter_id, :integer
  end
end
