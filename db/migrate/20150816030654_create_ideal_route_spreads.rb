class CreateIdealRouteSpreads < ActiveRecord::Migration
  def change
    create_table :ideal_route_spreads do |t|
      t.integer :YDS_5
      t.integer :YDS_6
      t.integer :YDS_7
      t.integer :YDS_8
      t.integer :YDS_9
      t.integer :YDS_10a
      t.integer :YDS_10b
      t.integer :YDS_10c
      t.integer :YDS_10d
      t.integer :YDS_11a
      t.integer :YDS_11b
      t.integer :YDS_11c
      t.integer :YDS_11d
      t.integer :YDS_12a
      t.integer :YDS_12b
      t.integer :YDS_12c
      t.integer :YDS_12d
      t.integer :YDS_13a
      t.integer :YDS_13b
      t.integer :YDS_13c
      t.integer :YDS_13d
      
      t.timestamps null: false
    end
  end
end
