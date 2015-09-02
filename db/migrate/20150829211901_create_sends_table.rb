class CreateSendsTable < ActiveRecord::Migration
  def change
    create_table :sends do |t|
      t.belongs_to :user, index: true
      t.belongs_to :climb, index: true
      t.timestamps null: false
    end
  end
end
