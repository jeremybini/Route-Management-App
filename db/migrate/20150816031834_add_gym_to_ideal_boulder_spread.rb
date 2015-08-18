class AddGymToIdealBoulderSpread < ActiveRecord::Migration
  def change
    add_reference :ideal_boulder_spreads, :gym, index: true, foreign_key: true
  end
end
