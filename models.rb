class User < ActiveRecord::Base
	has_many :skeets
end

class Skeet < ActiveRecord::Base
	belongs_to :User
end