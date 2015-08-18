class AddAttachmentImageToWalls < ActiveRecord::Migration
  def self.up
    change_table :walls do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :walls, :image
  end
end
