class AddDefaultValueToUsersRole < ActiveRecord::Migration
  def change
	change_column :users, :role, :string, :default => "User"
  end
end
