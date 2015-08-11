class Gym < ActiveRecord::Base
	has_many :walls
	has_many :routes, through: :walls
end
