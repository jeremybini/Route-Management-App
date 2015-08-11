class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.string :route_type
      t.string :color
      t.string :grade
      t.string :setter
      t.boolean :active, default: true
      t.belongs_to :wall, index: true, foreign_key: true
      t.belongs_to :gym, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
