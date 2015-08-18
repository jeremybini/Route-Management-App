class Climb < ActiveRecord::Base
  scope :active, -> { where(active: true) }
  scope :archived, -> { where(active: false) }
  scope :boulder, -> { where(climb_type: 'Boulder') }
  scope :route, -> { where(climb_type: 'Route') }

  belongs_to :wall
  belongs_to :gym

  has_attached_file :image, :styles => { large: "600x600>", medium: "300x300>", thumb: "150x150>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  enum grade: { 'VB': 0, 'V0': 1, 'V1': 2, 'V2': 3, 'V3': 4, 'V4': 5, 'V5': 6, 'V6': 7, 'V7': 8, 'V8': 9, 'V9': 10, 'V10': 11, 'V11': 12, 'V12': 13, 'V?': 14 }
end
