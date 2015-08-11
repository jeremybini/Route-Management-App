class Wall < ActiveRecord::Base
	has_many :routes
	belongs_to :gym
end
