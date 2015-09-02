class PagesController < ApplicationController
before_action :require_admin, only: [:contact]

  def home
  end

  def about
  end

  def contact
  	@climbs = Climb.all
  	@walls = Wall.all
  end
end
