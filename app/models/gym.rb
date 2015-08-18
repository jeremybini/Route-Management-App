class Gym < ActiveRecord::Base
	has_many :walls
	has_many :routes, through: :walls
	has_one :ideal_route_spread
	has_one :ideal_boulder_spread

	has_attached_file :image, :styles => { large: "600x600>", medium: "300x300>", thumb: "150x150>" }
  	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

	def self.all_boulder_grades
		['VB', 'V0', 'V1', 'V2', 'V3', 'V4', 'V5', 'V6', 'V7', 'V8', 'V9', 'V10', 'V11', 'V12']
	end

	def self.all_route_grades
		['5.5', '5.6', '5.7', '5.8', '5.9', '5.10a', '5.10b', '5.10c', '5.10d', '5.11a', '5.11b', '5.11c', '5.11d', '5.12a', '5.12b', '5.12c', '5.12d', '5.13a', '5.13b', '5.13c', '5.13d']
	end
end
