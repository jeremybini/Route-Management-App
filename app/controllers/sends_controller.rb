class SendsController < ApplicationController
  before_action :set_send, only: (:destroy)

  def new
  	#function to log previously sent routes..maybe should be directed here from the climb#show view, with an option to "Add previous sends"
  end

  def create
  	@send = Send.new(:climb_id => params[:climb_id], :user_id => params[:user_id])
  	respond_to do |format|
      if @send.save
        format.html { redirect_to wall_path(@send.climb.wall), notice: 'Climb sent! '+@send.climb.color+' '+@send.climb.grade+' sent on'+@send.created_at.to_s}
        format.json { head :no_content }
      else
        format.html { render :new }
        format.json { render json: @climb.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  	@send.destroy
    respond_to do |format|
      format.html { redirect_to profile_user_path(current_user), alert: "Send removed." }
      format.json { head :no_content }
    end
  end

  private
  	def set_send
  	  @send = Send.find(params[:id])
  	end

    def send_params
	  params.require(:send).permit(:climb_id, :user_id)
	end
end