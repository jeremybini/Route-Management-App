class WallsController < ApplicationController
  before_action :set_wall, only: [:show, :edit, :update, :archive, :destroy, :change_spread, :remove_image]
  before_action :wall_type, only: [:show, :edit, :update, :change_spread]
  before_action :require_routesetter, only: [:archive, :edit, :create, :update, :change_spread, :remove_image]
  before_action :require_admin, only: [:new]
  before_action :chart, only: [:show, :update]
  before_action :require_super_admin, only: [:destroy]
  
  helper_method :sort_climbs

  def show
  end

  def new
    @wall = Wall.new
    @gym = Gym.find(params[:gym_id])
  end

  def edit
  end

  def create
    @wall = Wall.new(wall_params)
    @new = true
    @updated_walls = @wall.gym.walls.where(wall_type: @wall.wall_type)
    respond_to do |format|
      if @wall.save
        format.html { redirect_to @wall.gym, notice: "The "+@wall.name.titleize+" was successfully created." }
        format.json { render :show, status: :created, location: @wall }
        format.js { flash.now[:notice] = "The "+@wall.name+" was successfully created." }
      else
        @gym = Gym.find(params[:gym_id])
        format.html { render :new }
        format.json { render json: @wall.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if @wall.update(wall_params)
        format.html { redirect_to @wall, info: @wall.name.titleize+' was successfully updated.' }
        format.json { render :show, status: :ok, location: @wall }
        format.js { flash.now[:notice] = @wall.name+' was successfully updated.' }
      else
        format.html { render :edit }
        format.json { render json: @wall.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def archive
    @climbs = @wall.climbs.active
    @climbs.each do |climb|
      climb.update_attribute(:active, false)
    end
    respond_to do |format|
      format.html { redirect_to wall_path(@wall), warning: 'Climbs on the '+@wall.name.titleize+' were successfully archived.' }
      format.json { head :no_content }
      format.js { flash.now[:warning] = 'All climbs on the '+@wall.name.titleize+' were successfully archived.' }
    end
  end

  def remove_image
    @wall.image = nil
    respond_to do |format|
      if @wall.save
        format.html { redirect_to @wall, alert: 'Wall photo successfully deleted.' }
        format.json { render :show, status: :created, location: @wall }
      else
        format.html { render :new }
        format.json { render json: @wall.errors, status: :unprocessable_entity }
      end
    end
  end

  def change_spread
    @walls = @wall.gym.walls.where(wall_type: @wall.wall_type)

    @ideal_gym_spread = []
    @wall_grades.each do |grade|
      count = 0
      @walls.each do |wall|
        unless wall.id === @wall.id
          count += wall.wall_spread[grade].to_i
        end
      end
      @ideal_gym_spread.push(count)
    end
  end

  def destroy
    @gym = @wall.gym
    @wall.destroy
    respond_to do |format|
      format.html { redirect_to gym_path(@gym), alert: 'The '+@wall.name+' was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_wall
      @wall = Wall.find(params[:id])
    end

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

    def chart
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
        
        f.xAxis(:categories => @wall_grades)
        f.yAxis(:allowDecimals => false)
        f.series(:name => "Current Amount", :yAxis => 0, :data => @current_grade_spread)
        if current_user && current_user.routesetter?
          f.series(:name => "Ideal Amount", :yAxis => 0, :data => @ideal_grade_spread)
          f.subtitle({ :text => "Ideal total: "+@ideal_grade_spread.reduce(:+).to_s })
        end
        f.plotOptions({:series => {:dataLabels => {:enabled => true, :color => 'black'}}})
        f.legend(:align => 'center', :verticalAlign => 'bottom', :layout => 'horizontal',)
        f.chart({:defaultSeriesType=>"column"})
      end
    end
end
