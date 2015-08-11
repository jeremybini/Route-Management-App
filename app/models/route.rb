class Route < ActiveRecord::Base
  default_scope { where(active: true) }

  belongs_to :wall
  belongs_to :gym

end
