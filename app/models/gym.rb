class Gym < ActiveRecord::Base
	has_many :walls, dependent: :destroy
	has_many :climbs, through: :walls, dependent: :destroy

	validates :name, :location, presence: true

	has_attached_file :image, :styles => { extra_large: "2000x2000", large: "800x800>", medium: "400x400>", thumbnail: "150x150>" }
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
