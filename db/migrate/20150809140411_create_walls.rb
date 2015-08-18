class CreateWalls < ActiveRecord::Migration
  def change
    create_table :walls do |t|
      t.string :name
      t.string :wall_image
      t.string :wall_type
      t.text :ideal_grade_spread
      t.belongs_to :gym, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
