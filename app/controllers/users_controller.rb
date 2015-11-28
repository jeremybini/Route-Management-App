class UsersController < ApplicationController
	before_action :require_admin, only: [:index, :destroy]
	before_action :require_user, only: [:profile, :edit, :update]
	before_action :require_correct_user, only: [:edit, :update]
	before_action :set_user, only: [:edit, :update, :profile, :destroy]
  
	def index
		@employees = User.where(role: ["Routesetter", "Admin", "Super Admin"]).order("role")
		@users = User.where(role: "User").order("full_name")
	end

	def new
		@user = User.new
	end

	def profile
		@all_sends = @user.sends.joins(:climb).order('climbs.grade')

		@send_count = Hash.new(0)
		@all_sends.each do |send|
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
	end

	def routesetter
	  @routesetter = User.find(params[:id])
	end

	def admin
    @setters = User.where(role: ["Routesetter", "Admin"]).order("full_name")
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to root_path, notice: "Thank you for signing up!"
		else
			render "new"
		end
	end

	def edit
	end

	def update
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to profile_user_path, notice: "Profile updated." }
          format.json { render :profile, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

	def destroy
		@user.destroy
	    respond_to do |format|
	      format.html { redirect_to users_path, alert: "User destroyed." }
	      format.json { head :no_content }
    	end
	end

	private

	  def set_user
	  	@user = User.find(params[:id])
	  end

	  def require_correct_user
	  	@user = User.find(params[:id])
  		redirect_to(root_url) unless @user == current_user || current_user.admin?
  	  end

	  def user_params
		params.require(:user).permit(:full_name, :email, :password_digest, :password, :password_confirmation, :role)
	  end
end
