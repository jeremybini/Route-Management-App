class Wall < ActiveRecord::Base
	has_many :climbs
	belongs_to :gym

	store :wall_spread, accessors: Climb::ALL_GRADES

	scope :boulder_wall, -> { where(wall_type: 'Boulder') }
  	scope :route_wall, -> { where(wall_type: 'Route') }

  	validates :name, :gym_id, :wall_type, presence: true

	has_attached_file :image, :styles => { large: "600x600>", medium: "300x300>", thumb: "150x150>" }
  	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
