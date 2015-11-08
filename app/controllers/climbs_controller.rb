class ClimbsController < ApplicationController
  before_action :set_climb, only: [:show, :edit, :update, :archive, :delete, :destroy]
  before_action :find_setters, only: [:new, :create, :edit, :update]
  before_action :require_routesetter, only: [:new, :edit, :create, :update, :archive, :destroy]
  
  helper_method :sort_climbs
  # GET wall/:id/routes
  # or
  # also visible in /wall/:id
  # which is better??
  # GET /routes.json

  # def index
  #    @climbs = @wall.climbs.active
  # end

  # GET /routes/1
  # GET /routes/1.json
  def show
    @wall = @climb.wall
  end

  # GET wall/:id/routes/new
  def new
    @climb = Climb.new
    @wall = Wall.find(params[:wall_id])
  end

  # GET /routes/1/edit
  def edit
  end

  # POST /routes
  # POST /routes.json
  def create
    sleep 0.5
    @new_climb = Climb.new(climb_params)
    @new_climb.setter_name||=@new_climb.setter.full_name
    @wall = @new_climb.wall
    @climbs = @wall.climbs.active.order(sort_climbs)
    @new = true

    respond_to do |format|
      if @new_climb.save
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
          if current_user && current_user.routesetter?
            f.series(:name => "Ideal Amount", :yAxis => 0, :data => @ideal_grade_spread)
            f.subtitle({ :text => "Ideal total: "+@ideal_grade_spread.reduce(:+).to_s })
          end
          f.plotOptions({:series => {:dataLabels => {:enabled => true, :color => 'black'}}})
          f.legend(:align => 'center', :verticalAlign => 'bottom', :layout => 'horizontal',)
          f.chart({:defaultSeriesType=>"column"})
        end
        format.html { redirect_to new_wall_climb_path(@new_climb.wall), notice: 'Added to '+@new_climb.wall.name+': '+@new_climb.color+' '+@new_climb.grade+', set by '+@new_climb.setter_name+'.' }
        format.json { render :show, status: :created, location: @new_climb }
        format.js { flash.now[:notice] = 'Added: '+@new_climb.color+' '+@new_climb.grade+', set by '+@new_climb.setter_name+'.' }
        @climb = Climb.new
      else
        @wall = Wall.find(params[:wall_id])
        format.js
        format.html { render :new }
        format.json { render json: @climb.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /routes/1
  # PATCH/PUT /routes/1.json
  def update
    @wall = @climb.wall
    @climbs = @wall.climbs.active.order(sort_climbs)
    respond_to do |format|
      if @climb.update(climb_params)
        wall_grades = []
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
          if current_user && current_user.routesetter?
            f.series(:name => "Ideal Amount", :yAxis => 0, :data => @ideal_grade_spread)
            f.subtitle({ :text => "Ideal total: "+@ideal_grade_spread.reduce(:+).to_s })
          end
          f.plotOptions({:series => {:dataLabels => {:enabled => true, :color => 'black'}}})
          f.legend(:align => 'center', :verticalAlign => 'bottom', :layout => 'horizontal',)
          f.chart({:defaultSeriesType=>"column"})
        end
        format.html { redirect_to @climb.wall, notice: @climb.color+" "+@climb.grade+" was successfully updated." }
        format.json { render :show, status: :ok, location: @climb }
        format.js { flash.now[:notice] = @climb.color+" "+@climb.grade+" was successfully updated." }
      else
        format.js
        format.html { render :edit }
        format.json { render json: @climb.errors, status: :unprocessable_entity }
      end
    end
  end

  def archive
    @climb.toggle!(:active)
    @wall = @climb.wall
    @climbs = @wall.climbs.active.order(sort_climbs)
    @archived_climbs = @wall.climbs.archived
    respond_to do |format|
      if @climb.active === false
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
          if current_user && current_user.routesetter?
            f.series(:name => "Ideal Amount", :yAxis => 0, :data => @ideal_grade_spread)
            f.subtitle({ :text => "Ideal total: "+@ideal_grade_spread.reduce(:+).to_s })
          end
          f.plotOptions({:series => {:dataLabels => {:enabled => true, :color => 'black'}}})
          f.legend(:align => 'center', :verticalAlign => 'bottom', :layout => 'horizontal',)
          f.chart({:defaultSeriesType=>"column"})
        end
        format.html { redirect_to @climb.wall, warning: @climb.color+" "+@climb.grade+" was successfully archived." }
        format.json { head :no_content }
        format.js { flash.now[:warning] = @climb.color+" "+@climb.grade+" was successfully archived." }
      else
        format.js { flash.now[:success] = @climb.color+" "+@climb.grade+" was reactivated!" }
        format.html { redirect_to @climb.wall, info: @climb.color+" "+@climb.grade+" was reactivated!" }
        format.json { head :no_content }
      end
    end
  end

  # DELETE /routes/1
  # DELETE /routes/1.json
  def destroy
    @wall = @climb.wall
    @climb.destroy
    @climbs = @wall.climbs.active.order(sort_climbs)

    respond_to do |format|
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
        if current_user && current_user.routesetter?
          f.series(:name => "Ideal Amount", :yAxis => 0, :data => @ideal_grade_spread)
          f.subtitle({ :text => "Ideal total: "+@ideal_grade_spread.reduce(:+).to_s })
        end
        f.plotOptions({:series => {:dataLabels => {:enabled => true, :color => 'black'}}})
        f.legend(:align => 'center', :verticalAlign => 'bottom', :layout => 'horizontal',)
        f.chart({:defaultSeriesType=>"column"})
      end
      format.html { redirect_to @climb.wall, alert: @climb.color+" "+@climb.grade+" was successfully destroyed." }
      format.json { head :no_content }
      format.js { flash.now[:alert] = @climb.color+" "+@climb.grade+" was successfully deleted." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_climb
      @climb = Climb.find(params[:id])
    end

    def sort_climbs
      params[:sort] ||= "grade"
    end

    def find_setters
      @all_registered_setters = User.where(role: ["Routesetter", "Admin"]).order("full_name")
      @setters = @all_registered_setters.map{|u| [ u.full_name, u.id ] }.push(["Other", "Other"])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def climb_params
      params.require(:climb).permit(:climb_type, :color, :grade, :grade_enum, :setter_name, :wall_id, :gym_id, :image, :active, :created_at, :setter_id)
    end
end
