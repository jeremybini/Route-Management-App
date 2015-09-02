class Gym < ActiveRecord::Base
	has_many :walls, dependent: :destroy
	has_many :climbs, through: :walls, dependent: :destroy

	validates :name, :location, presence: true

	has_attached_file :image, :styles => { large: "600x600>", medium: "300x300>", thumb: "150x150>" }
  	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  	before_save :extract_dimensions

  	def extract_dimensions
    return unless image?
      tempfile = upload.queued_for_write[:original]
    unless tempfile.nil?
      geometry = Paperclip::Geometry.from_file(tempfile)
      if geometry.width.to_i/geometry.height.to_i > 1
        self.image_orientation = "Landscape"
      else
        self.image_orientation = "Portrait"
      end
    end
  end
end
