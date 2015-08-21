class ClimbsController < ApplicationController
  before_action :set_climb, only: [:show, :edit, :update, :archive, :destroy]
  before_action :require_routesetter, only: [:new, :edit, :create, :update, :archive, :destroy]

  # GET wall/:id/routes
  # or
  # also visible in /wall/:id
  # which is better??
  # GET /routes.json

  def index
     @climbs = @wall.climbs.active
  end

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
    @climb = Climb.new(climb_params)

    respond_to do |format|
      if @climb.save
        format.html { redirect_to new_wall_climb_path(@climb.wall), notice: 'Added to '+@climb.wall.name+': '+@climb.color+' '+@climb.grade+', set by '+@climb.setter+'.' }
        format.json { render :show, status: :created, location: @climb }
      else
        @wall = Wall.find(params[:wall_id])
        format.html { render :new }
        format.json { render json: @climb.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /routes/1
  # PATCH/PUT /routes/1.json
  def update
    respond_to do |format|
      if @climb.update(climb_params)
        format.html { redirect_to @climb, notice: 'Climb was successfully updated.' }
        format.json { render :show, status: :ok, location: @climb }
      else
        format.html { render :edit }
        format.json { render json: @climb.errors, status: :unprocessable_entity }
      end
    end
  end

  def archive
    @climb.toggle!(:active)
    respond_to do |format|
      if @climb.active === false
        format.html { redirect_to wall_path(@climb.wall), notice: 'Climb was successfully archived.' }
        format.json { head :no_content }
      else
        format.html { redirect_to wall_path(@climb.wall), notice: 'Climb was reactivated!' }
        format.json { head :no_content }
      end
    end
  end

  # DELETE /routes/1
  # DELETE /routes/1.json
  def destroy
    @climb.destroy
    respond_to do |format|
      format.html { redirect_to wall_path(@climb.wall), notice: 'Climb was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_climb
      @climb = Climb.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def climb_params
      params.require(:climb).permit(:climb_type, :color, :grade, :grade_enum, :setter, :wall_id, :image, :active)
    end
end
