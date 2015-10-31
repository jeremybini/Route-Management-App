class GymsController < ApplicationController
  before_action :set_gym, only: [:show, :edit, :update, :destroy, :remove_image]
  before_action :require_routesetter, only: [:edit, :update]
  before_action :require_admin, only: [:new, :create, :destroy, :remove_image]
  before_action :route_chart, only: [:show, :update]
  before_action :boulder_chart, only: [:show, :update]

  # GET /gyms
  # GET /gyms.json
  def index
    @gyms = Gym.all
  end

  # GET /gyms/1
  # GET /gyms/1.json
  def show
  end

  # GET /gyms/new
  def new
    @gym = Gym.new
  end

  # GET /gyms/1/edit
  def edit
  end

  # POST /gyms
  # POST /gyms.json
  def create
    @gym = Gym.new(gym_params)

    respond_to do |format|
      if @gym.save
        format.html { redirect_to @gym, notice: 'Gym was successfully created.' }
        format.json { render :show, status: :created, location: @gym }
      else
        format.html { render :new }
        format.json { render json: @gym.errors, status: :unprocessable_entity }
      end
    end
  end

  def remove_image
    @gym.image = nil
    respond_to do |format|
      if @gym.save
        format.html { redirect_to @gym, alert: 'Gym photo successfully deleted.' }
        format.json { render :show, status: :created, location: @gym }
      else
        format.html { render :new }
        format.json { render json: @gym.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gyms/1
  # PATCH/PUT /gyms/1.json
  def update
    respond_to do |format|
      if @gym.update(gym_params)
        format.html { redirect_to @gym, info: 'Gym was successfully updated.' }
        format.json { render :show, status: :ok, location: @gym }
      else
        format.html { render :edit }
        format.json { render json: @gym.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gyms/1
  # DELETE /gyms/1.json
  def destroy
    @gym.destroy
    respond_to do |format|
      format.html { redirect_to gyms_url, alert: 'Gym was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gym
      @gym = Gym.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gym_params
      params.require(:gym).permit(:name, :location, :image)
    end

    def route_chart
      @route_walls = @gym.walls.route_wall.order("name")
      @route_grades = Climb::ROUTE_GRADES

      @route_grade_spread = []
      @route_grades.each do |grade|
        @route_grade_spread.push(@gym.climbs.active.where(grade: Climb.grades[grade]).count)
      end

      @ideal_route_spread = []
      @route_grades.each do |grade|
        count = 0
        @gym.walls.each do |wall|
          count += wall.wall_spread[grade].to_i
        end
        @ideal_route_spread.push(count)
      end

      @route_chart = LazyHighCharts::HighChart.new('graph') do |f|
        f.title(:text => "There are "+@gym.climbs.active.route.count.to_s+" active routes at "+@gym.name)
        f.chart({:defaultSeriesType=>"column"})
        f.xAxis(:categories => @route_grades)
        f.series(:name => "Current Amount", :yAxis => 0, :data => @route_grade_spread)
        if current_user && current_user.routesetter?  
          f.series(:name => "Ideal Amount", :yAxis => 0, :data => @ideal_route_spread)
          f.subtitle({ :text => "Ideal total: "+@ideal_route_spread.inject(:+).to_s })
        end
        f.yAxis [
          {:title => {:text => "Total Climbs"}, :allowDecimals => false },
        ]
        f.plotOptions({:column => {:dataLabels => {:enabled => true, :color => 'black'}}})
        f.legend(:align => 'center', :verticalAlign => 'bottom', :layout => 'horizontal',)
      end
    end

    def boulder_chart
      @boulder_walls = @gym.walls.boulder_wall.order("name")
      @boulder_grades = Climb::BOULDER_GRADES

      @boulder_grade_spread = []
      @boulder_grades.each do |grade|
        @boulder_grade_spread.push(@gym.climbs.active.where(grade: Climb.grades[grade]).count)
      end

      @ideal_boulder_spread = []
      @boulder_grades.each do |grade|
        count = 0
        @gym.walls.each do |wall|
          count += wall.wall_spread[grade].to_i
        end
        @ideal_boulder_spread.push(count)
      end

      @boulder_chart = LazyHighCharts::HighChart.new('graph') do |f|
        f.title(:text => "There are "+@gym.climbs.active.boulder.count.to_s+" active boulders at "+@gym.name)
        f.chart({:defaultSeriesType=>"column"})
        f.xAxis(:categories => @boulder_grades)
        f.series(:name => "Current Amount", :yAxis => 0, :data => @boulder_grade_spread)
        if current_user && current_user.routesetter?
          f.series(:name => "Ideal Amount", :yAxis => 0, :data => @ideal_boulder_spread)
          f.subtitle({ :text => "Ideal total: "+@ideal_boulder_spread.inject(:+).to_s })
        end
        f.yAxis [
          {:title => {:text => "Total Climbs"}, :allowDecimals => false },
        ]
        f.plotOptions({:column => {:dataLabels => {:enabled => true, :color => 'black'}}})
        f.legend(:align => 'center', :verticalAlign => 'bottom', :layout => 'horizontal',)
      end
    end
end
