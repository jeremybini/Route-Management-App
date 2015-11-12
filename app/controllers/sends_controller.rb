class SendsController < ApplicationController
  before_action :set_send, only: [:destroy, :remove_climb]
  
  def new
  	#function to log previously sent routes..maybe should be directed here from climb#show view, with an option to "Add previous sends"
  end

  def create
    sleep 0.5
  	@send = Send.new(:climb_id => params[:climb_id], :user_id => params[:user_id])
  	respond_to do |format|
      if @send.save
        format.html { redirect_to wall_path(@send.climb.wall), notice: 'Climb sent! '+@send.climb.color+' '+@send.climb.grade+' sent on'+@send.created_at.to_s}
        format.json { head :no_content }
        format.js
      else
        format.html { render :new }
        format.json { render json: @climb.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  	@send.destroy
    @user = @send.user

    @sends = @user.sends.joins(:climb).order('climbs.grade')

    @send_count = Hash.new(0)
    @sends.each do |send|
      @send_count[send.climb.grade]+=1
    end

    @send_data = []
    @send_count.map{ |grade, count| @send_data.push([grade, count]) }

    @grade_chart = LazyHighCharts::HighChart.new('pie') do |f|
        f.chart({ :defaultSeriesType=>"pie",
                  :margin=> [50, 0, 0, 0] ,
                  :spacingBottom=>0
                })
        series = {
                 :type=> 'pie',
                 :name=> 'Ascents by Grade',
                 :data=> @send_data
        }
        f.series(series)
        f.options[:title][:text] = "Ascents by Grade"
        f.legend(:layout=> 'vertical',:style=> {:left=> 'auto', :bottom=> 'auto',:right=> '50px',:top=> '100px'}) 
        f.tooltip({
          :pointFormat=> '{series.name}: <b>{point.y} ({point.percentage:.1f}%)</b>'
        })
        f.plot_options(:pie=>{
          :allowPointSelect=>true, 
          :cursor=>"pointer" , 
          :dataLabels=>{
            :format=> '<b>{point.name}</b>: {point.y} Ascents',
            :enabled=>true,
            :color=>"black",
            :style=>{
              :font=>"13px Trebuchet MS, Verdana, sans-serif"
            }
          }
        })
    end
    respond_to do |format|
      format.html { redirect_to profile_user_path(current_user), alert: "Send removed." }
      format.json { head :no_content }
      format.js
    end
  end

  def remove_climb
    @climb = @send.climb
    @user = @send.user

    @sends = Send.all.where(:climb_id => @climb.id).where(:user_id => @user)
    @sends.destroy_all

    @chart_sends = @user.sends.joins(:climb).order('climbs.grade')

    @send_count = Hash.new(0)
    @chart_sends.each do |send|
      @send_count[send.climb.grade]+=1
    end

    @send_data = []
    @send_count.map{ |grade, count| @send_data.push([grade, count]) }

    @grade_chart = LazyHighCharts::HighChart.new('pie') do |f|
        f.chart({ :defaultSeriesType=>"pie",
                  :margin=> [50, 0, 0, 0] ,
                  :spacingBottom=>0
                })
        series = {
                 :type=> 'pie',
                 :name=> 'Ascents by Grade',
                 :data=> @send_data
        }
        f.series(series)
        f.options[:title][:text] = "Ascents by Grade"
        f.legend(:layout=> 'vertical',:style=> {:left=> 'auto', :bottom=> 'auto',:right=> '50px',:top=> '100px'}) 
        f.tooltip({
          :pointFormat=> '{series.name}: <b>{point.y} ({point.percentage:.1f}%)</b>'
        })
        f.plot_options(:pie=>{
          :allowPointSelect=>true, 
          :cursor=>"pointer" , 
          :dataLabels=>{
            :format=> '<b>{point.name}</b>: {point.y} Ascents',
            :enabled=>true,
            :color=>"black",
            :style=>{
              :font=>"13px Trebuchet MS, Verdana, sans-serif"
            }
          }
        })
    end
    respond_to do |format|
      format.js
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