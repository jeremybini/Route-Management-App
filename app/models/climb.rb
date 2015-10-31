class Climb < ActiveRecord::Base
  belongs_to :wall
  belongs_to :gym
  belongs_to :setter, class_name: "User"

  has_many :sends
  has_many :users, through: :sends

  scope :active, -> { where(active: true) }
  scope :archived, -> { where(active: false) }
  scope :boulder, -> { where(climb_type: 'Boulder') }
  scope :route, -> { where(climb_type: 'Route') }

  validates :climb_type, :color, :grade, :setter_id, :setter_name, :wall_id, presence: true

  has_attached_file :image, :styles => { large: "600x600>", medium: "300x300>", thumb: "150x150>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  before_save :extract_dimensions
  after_create :chart

  #enum grade: { "VB": 0, "V0": 1, "V1": 2, "V2": 3, "V3": 4, "V4": 5, "V5": 6, "V6": 7, "V7": 8, "V8": 9, "V9": 10, "V10": 11, "V11": 12, "V12": 13, "V13": 14, "V14": 15, "V15": 16, "V16": 17, "V?": 18, "5.5": 19, "5.6": 20, "5.7": 21, "5.8": 22, "5.9": 23, "5.10a": 24, "5.10b": 25, "5.10c": 26, "5.10d": 27, "5.11a": 28, "5.11b": 29, "5.11c": 30, "5.11d": 31, "5.12a": 32, "5.12b": 33, "5.12c": 34, "5.12d": 35, "5.13a": 36, "5.13b": 37, "5.13c": 38, "5.13d": 39, "5.14a": 40, "5.14b": 41, "5.14c": 42, "5.14d": 43, "5.15a": 44, "5.15b": 45, "5.15c": 46, "5.?": 47 }
  
  enum grade: ['VB', 'V0', 'V1', 'V2', 'V3', 'V4', 'V5', 'V6', 'V7', 'V8', 'V9', 'V10', 'V11', 'V12', 'V?', '5.5', '5.6', '5.7', '5.8', '5.9', '5.10a', '5.10b', '5.10c', '5.10d', '5.11a', '5.11b', '5.11c', '5.11d', '5.12a', '5.12b', '5.12c', '5.12d', '5.13a', '5.13b', '5.13c', '5.13d', '5.?']
  
  BOULDER_GRADES = ['VB', 'V0', 'V1', 'V2', 'V3', 'V4', 'V5', 'V6', 'V7', 'V8', 'V9', 'V10', 'V11', 'V12', 'V?']
  ROUTE_GRADES = ['5.5', '5.6', '5.7', '5.8', '5.9', '5.10a', '5.10b', '5.10c', '5.10d', '5.11a', '5.11b', '5.11c', '5.11d', '5.12a', '5.12b', '5.12c', '5.12d', '5.13a', '5.13b', '5.13c', '5.13d', '5.?']
  
  ALL_GRADES = BOULDER_GRADES+ROUTE_GRADES

  COLORS = ['Black', 'Blue', 'Green', 'Lime', 'Orange', 'Pink', 'Purple', 'Red', 'Teal', 'White', 'Yellow', 'Other']

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

  def chart
    @wall = self.wall
    @climbs = @wall.climbs.active.order("grade")

    @wall_grades = []
    if @wall.wall_type==='Route'
      @wall_grades = Climb::ROUTE_GRADES
    else
      @wall_grades = Climb::BOULDER_GRADES
    end
    
    @ideal_grade_spread = []
    @wall_grades.each do |grade|
      @ideal_grade_spread.push(@wall.wall_spread[grade].to_i)
    end

    @current_grade_spread = []

    @wall_grades.each do |grade|
      @current_grade_spread.push(@climbs.active.where(grade: Climb.grades[grade]).count)
    end

    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title({ :text => "There are "+@climbs.count.to_s+" active climbs on the "+@wall.name })
      
      f.xAxis(:categories => @wall_grades)
      f.yAxis(:allowDecimals => false)
      f.series(:name => "Current Amount", :yAxis => 0, :data => @current_grade_spread)
      f.series(:name => "Ideal Amount", :yAxis => 0, :data => @ideal_grade_spread)
      f.subtitle({ :text => "Ideal total: "+@ideal_grade_spread.reduce(:+).to_s })
      f.plotOptions({:series => {:dataLabels => {:enabled => true, :color => 'black'}}})
      f.legend(:align => 'center', :verticalAlign => 'bottom', :layout => 'horizontal',)
      f.chart({:defaultSeriesType=>"column"})
    end
  end
  
end
