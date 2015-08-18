class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.string :climb_type
      t.string :color
      t.integer :boulder_grade
      t.integer :route_grade
      t.string :setter
      t.boolean :active, default: true
      t.belongs_to :wall, index: true, foreign_key: true
      t.belongs_to :gym, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
