class Route < ActiveRecord::Base
  scope :active, -> { where(active: true) }
  scope :archived, -> { where(active: false) }
  scope :boulder, -> { where(route_type: 'Boulder') }
  scope :route, -> { where(route_type: 'Route') }

  belongs_to :wall
  belongs_to :gym

  has_attached_file :image, :styles => { large: "600x600>", medium: "300x300>", thumb: "150x150>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
