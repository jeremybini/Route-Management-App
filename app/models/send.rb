class Send < ActiveRecord::Base
	belongs_to :climb
  belongs_to :user
end
