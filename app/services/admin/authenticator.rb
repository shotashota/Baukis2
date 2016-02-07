class Admin::Authenticator
	def initialize(administrator)
		@administrator = administrator
	end

	def authenticate(raw_password)
		@administrator.present? &&
			!@administrator.suspended?
	end
end