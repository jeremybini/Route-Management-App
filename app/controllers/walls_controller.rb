class WallsController < ApplicationController
  before_action :set_wall, only: [:show, :edit, :update, :archive, :destroy, :change_spread]
  before_action :wall_type, only: [:show, :edit, :change_spread]
  before_action :require_routesetter, only: [:archive, :edit, :create, :update]
  before_action :require_admin, only: [:new, :destroy]

  helper_method :sort_climbs
  # GET /walls
  # GET /walls.json
  def index
    @walls = Wall.all
  end

  # GET /walls/1
  # GET /walls/1.json
  def show
    @climbs = @wall.climbs.active.order(sort_climbs)
    @archived_climbs = @wall.climbs.archived

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
      f.subtitle({ :text => "Ideal total: "+@ideal_grade_spread.reduce(:+).to_s })
      f.xAxis(:categories => @wall_grades)
      f.yAxis(:allowDecimals => false)
      f.series(:name => "Current Amount", :yAxis => 0, :data => @current_grade_spread)
      f.series(:name => "Ideal Amount", :yAxis => 0, :data => @ideal_grade_spread)
      f.legend(:align => 'center', :verticalAlign => 'bottom', :layout => 'horizontal',)
      f.chart({:defaultSeriesType=>"column"})
    end
  end

  # GET /walls/new
  def new
    @wall = Wall.new
    @gym = Gym.find(params[:gym_id])
  end

  # GET /walls/1/edit
  def edit
  end

  # POST /walls
  # POST /walls.json
  def create
    @wall = Wall.new(wall_params)

    respond_to do |format|
      if @wall.save
        format.html { redirect_to @wall, notice: 'Wall was successfully created.' }
        format.json { render :show, status: :created, location: @wall }
      else
        @gym = Gym.find(params[:gym_id])
        format.html { render :new }
        format.json { render json: @wall.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /walls/1
  # PATCH/PUT /walls/1.json
  def update
    respond_to do |format|
      if @wall.update(wall_params)
        format.html { redirect_to @wall, notice: 'Wall was successfully updated.' }
        format.json { render :show, status: :ok, location: @wall }
      else
        format.html { render :edit }
        format.json { render json: @wall.errors, status: :unprocessable_entity }
      end
    end
  end

  def archive
    @climbs = @wall.climbs.active
    @climbs.each do |climb|
      climb.update_attribute(:active, false)
    end
    respond_to do |format|
      format.html { redirect_to wall_path(@wall), notice: 'Climbs were successfully archived.' }
      format.json { head :no_content }
    end
  end

  def change_spread
    @gym = Gym.find(params[:gym_id])
    @walls = Gym.find

    @ideal_boulder_spread = []
    @boulder_grades.each do |grade|
      count = 0
      @gym.walls.each do |wall|
        count += wall.wall_spread[grade].to_i
      end
      @ideal_boulder_spread.push(count)
    end
  end

  # DELETE /walls/1
  # DELETE /walls/1.json
  def destroy
    @wall.destroy
    respond_to do |format|
      format.html { redirect_to walls_url, notice: 'Wall was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wall
      @wall = Wall.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wall_params
      params.require(:wall).permit(:name, :image, :wall_type, :gym_id, :wall_spread, Climb::ALL_GRADES)
    end

    def sort_climbs
      params[:sort] ||= "grade"
    end

    def wall_type
      @wall_grades = []
      if @wall.wall_type==='Route'
        @wall_grades = Climb::ROUTE_GRADES
      else
        @wall_grades = Climb::BOULDER_GRADES
      end
    end
end
