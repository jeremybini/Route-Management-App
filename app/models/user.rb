class User < ActiveRecord::Base
	has_secure_password

	validates_uniqueness_of :email, :on => :create, :message => 'This account already exists'

	def routesetter?
		self.role == 'routesetter' || self.role == 'admin'
	end

	def admin?
		self.role == 'admin'
	end
end
