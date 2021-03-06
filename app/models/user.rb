class User < ActiveRecord::Base
	has_secure_password

	has_many :set_climbs, foreign_key: "setter_id", class_name: 'Climb'

	has_many :sends, dependent: :destroy
	has_many :climbs, through: :sends

	validates_uniqueness_of :email, :on => :create, :message => 'This account already exists'
	before_create { generate_token(:auth_token) }

	def send_password_reset
		generate_token(:password_reset_token)
		self.password_reset_sent_at = Time.zone.now
		save!
		UserMailer.password_reset(self).deliver
	end

	def generate_token(column)
		begin
			self[column] = SecureRandom.urlsafe_base64
		end while User.exists?(column => self[column])
	end

	def routesetter?
		self.role === 'Routesetter' || self.role === 'Admin' || self.role === 'Super Admin'
	end

	def admin?
		self.role === 'Admin' || self.role === 'Super Admin'
	end

	def super_admin?
		self.role === 'Super Admin'
	end
end
