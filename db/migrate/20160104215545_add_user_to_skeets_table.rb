class AddUserToSkeetsTable < ActiveRecord::Migration
  def change
  	add_column :skeets, :user, :integer
  	remove_column :skeets, :author
  end
end
