class Climb < ActiveRecord::Base
  belongs_to :wall
  belongs_to :gym

  scope :active, -> { where(active: true) }
  scope :archived, -> { where(active: false) }
  scope :boulder, -> { where(climb_type: 'Boulder') }
  scope :route, -> { where(climb_type: 'Route') }

  validates :climb_type, :color, :grade, :setter, :wall_id, presence: true

  has_attached_file :image, :styles => { large: "600x600>", medium: "300x300>", thumb: "150x150>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  #enum grade: { "VB": 0, "V0": 1, "V1": 2, "V2": 3, "V3": 4, "V4": 5, "V5": 6, "V6": 7, "V7": 8, "V8": 9, "V9": 10, "V10": 11, "V11": 12, "V12": 13, "V13": 14, "V14": 15, "V15": 16, "V16": 17, "V?": 18, "5.5": 19, "5.6": 20, "5.7": 21, "5.8": 22, "5.9": 23, "5.10a": 24, "5.10b": 25, "5.10c": 26, "5.10d": 27, "5.11a": 28, "5.11b": 29, "5.11c": 30, "5.11d": 31, "5.12a": 32, "5.12b": 33, "5.12c": 34, "5.12d": 35, "5.13a": 36, "5.13b": 37, "5.13c": 38, "5.13d": 39, "5.14a": 40, "5.14b": 41, "5.14c": 42, "5.14d": 43, "5.15a": 44, "5.15b": 45, "5.15c": 46, "5.?": 47 }
  
  enum grade: ['VB', 'V0', 'V1', 'V2', 'V3', 'V4', 'V5', 'V6', 'V7', 'V8', 'V9', 'V10', 'V11', 'V12', 'V?', '5.5', '5.6', '5.7', '5.8', '5.9', '5.10a', '5.10b', '5.10c', '5.10d', '5.11a', '5.11b', '5.11c', '5.11d', '5.12a', '5.12b', '5.12c', '5.12d', '5.13a', '5.13b', '5.13c', '5.13d', '5.?']
  
  BOULDER_GRADES = ['VB', 'V0', 'V1', 'V2', 'V3', 'V4', 'V5', 'V6', 'V7', 'V8', 'V9', 'V10', 'V11', 'V12', 'V?']
  ROUTE_GRADES = ['5.5', '5.6', '5.7', '5.8', '5.9', '5.10a', '5.10b', '5.10c', '5.10d', '5.11a', '5.11b', '5.11c', '5.11d', '5.12a', '5.12b', '5.12c', '5.12d', '5.13a', '5.13b', '5.13c', '5.13d', '5.?']
  
  ALL_GRADES = BOULDER_GRADES+ROUTE_GRADES

  COLORS = ['Black', 'Blue', 'Green', 'Lime', 'Orange', 'Pink', 'Purple', 'Red', 'Teal', 'White', 'Yellow', 'Other']
end
