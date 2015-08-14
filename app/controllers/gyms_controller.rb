class GymsController < ApplicationController
  before_action :set_gym, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:new, :edit, :create, :update, :destroy]

  # GET /gyms
  # GET /gyms.json
  def index
    @gyms = Gym.all
  end

  # GET /gyms/1
  # GET /gyms/1.json
  def show
    @walls = @gym.walls

    @route_grades = Gym.all_route_grades
    @boulder_grades= Gym.all_boulder_grades
    
    @boulder_grade_spread = []

    @boulder_grades.each do |grade|
      @boulder_grade_spread.push(@gym.routes.where("grade = '"+grade+"'").count)
    end

    @route_grade_spread = []

    @route_grades.each do |grade|
      @route_grade_spread.push(@gym.routes.where("grade = '"+grade+"'").count)
    end

    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(:text => "There are "+@gym.routes.count.to_s+" active climbs at "+@gym.name)
      f.xAxis(:categories => @boulder_grades)
      f.series(:name => "Current Grade Spread", :yAxis => 0, :data => @boulder_grade_spread)

      f.yAxis [
        {:title => {:text => "Total Climbs"} },
      ]

      f.legend(:align => 'center', :verticalAlign => 'bottom', :layout => 'horizontal',)
      f.chart({:defaultSeriesType=>"column"})
    end
    #boulder_grade_spread = Route.group("grade = "+@boulder_grades).count
    
    # @route_grade_spread = Route.where("route_type = 'Route'").group("grade").order("grade asc").count
    # @route_grade_spread.each do |grade, count|
    #   @route_grades.push(grade)
    #   @route_grades_count.push(count)
    # end

    # @boulder_grade_spread = Route.where("route_type = 'Boulder'").group("grade").count
    # @boulder_grade_spread.each do |grade, count|
    #   @boulder_grades.push(grade)
    #   @boulder_grades_count.push(count)
    # end
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

  # PATCH/PUT /gyms/1
  # PATCH/PUT /gyms/1.json
  def update
    respond_to do |format|
      if @gym.update(gym_params)
        format.html { redirect_to @gym, notice: 'Gym was successfully updated.' }
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
      format.html { redirect_to gyms_url, notice: 'Gym was successfully destroyed.' }
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
      params.require(:gym).permit(:name, :location, :gym_image)
    end
end
