class CreateIdealBoulderSpreads < ActiveRecord::Migration
  def change
    create_table :ideal_boulder_spreads do |t|
      t.integer :VB
      t.integer :V0
      t.integer :V1
      t.integer :V2
      t.integer :V3
      t.integer :V4
      t.integer :V5
      t.integer :V6
      t.integer :V7
      t.integer :V8
      t.integer :V9
      t.integer :V10
      t.integer :V11
      t.integer :V12
      t.integer :V13
      
      t.timestamps null: false
    end
  end
end
