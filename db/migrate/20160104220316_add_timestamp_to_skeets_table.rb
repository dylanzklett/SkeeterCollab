class AddTimestampToSkeetsTable < ActiveRecord::Migration
  def change
  	add_column(:skeets, :timestamp, :datetime)
  end
end
