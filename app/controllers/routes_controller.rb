class RoutesController < ApplicationController
  before_action :set_route, only: [:show, :edit, :update, :archive, :destroy]
  before_action :require_routesetter, only: [:new, :edit, :create, :update, :archive, :destroy]

  # GET wall/:id/routes
  # or
  # also visible in /wall/:id
  # which is better??
  # GET /routes.json

  def index
     @routes = @wall.routes.active
  end

  # GET /routes/1
  # GET /routes/1.json
  def show
    @wall = @route.wall
  end

  # GET wall/:id/routes/new
  def new
    @route = Route.new
    @wall = Wall.find(params[:wall_id])
  end

  # GET /routes/1/edit
  def edit
  end

  # POST /routes
  # POST /routes.json
  def create
    @route = Route.new(route_params)

    respond_to do |format|
      if @route.save
        format.html { redirect_to new_wall_route_path(@route.wall), notice: 'Added: '+@route.color+' '+@route.grade+', set by '+@route.setter+'.' }
        format.json { render :show, status: :created, location: @route }
      else
        format.html { render :new }
        format.json { render json: @route.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /routes/1
  # PATCH/PUT /routes/1.json
  def update
    respond_to do |format|
      if @route.update(route_params)
        format.html { redirect_to @route, notice: 'Climb was successfully updated.' }
        format.json { render :show, status: :ok, location: @route }
      else
        format.html { render :edit }
        format.json { render json: @route.errors, status: :unprocessable_entity }
      end
    end
  end

  def archive
    @route.toggle!(:active)
    respond_to do |format|
      if @route.active === false
        format.html { redirect_to wall_path(@route.wall), notice: 'Climb was successfully archived.' }
        format.json { head :no_content }
      else
        format.html { redirect_to wall_path(@route.wall), notice: 'Climb was reactivated!' }
        format.json { head :no_content }
      end
    end
  end

  # DELETE /routes/1
  # DELETE /routes/1.json
  def destroy
    @route.destroy
    respond_to do |format|
      format.html { redirect_to wall_path(@route.wall), notice: 'Climb was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_route
      @route = Route.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def route_params
      params.require(:route).permit(:route_type, :color, :grade, :setter, :wall_id, :image, :active)
    end
end
