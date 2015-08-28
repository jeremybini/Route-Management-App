class Wall < ActiveRecord::Base
	has_many :climbs
	belongs_to :gym

	store :wall_spread, accessors: Climb::ALL_GRADES

	scope :boulder_wall, -> { where(wall_type: 'Boulder') }
  	scope :route_wall, -> { where(wall_type: 'Route') }

  	validates :name, :gym_id, :wall_type, presence: true

	has_attached_file :image, :styles => { large: "800x800>", medium: "400x400>", thumbnail: "150x150>" }
  	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  	after_post_process :extract_dimensions

  	def extract_dimensions
	    return unless image?
	      tempfile = image.queued_for_write[:large]
	    unless tempfile.nil?
	      geometry = Paperclip::Geometry.from_file(Paperclip.io_adapters.for(tempfile))
	      self.image_orientation = "Width: "+geometry.width.to_s+".......Height: "+geometry.height.to_s

	      if geometry.width.to_i > geometry.height.to_i
	        self.image_orientation = "Landscape"
	      else
	        self.image_orientation = "Portrait"
	      end
	    end
	end

end
