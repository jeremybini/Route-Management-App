class AddAttachmentImageToGyms < ActiveRecord::Migration
  def self.up
    change_table :gyms do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :gyms, :image
  end
end
