class CreateSkeetsTable < ActiveRecord::Migration
  def change
  	create_table :skeets do |t|
  		t.string :title
  		t.string :body
  		t.integer :author
  	end
  end
end
