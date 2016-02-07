class Admin::SessionsController < Admin::Base

	skip_before_action :authorize

	def new
		if current_administrator
			redirect_to :admin_root
		else
			@form = Admin::LoginForm.new
		end
	end

	def create
		@form = Admin::LoginForm.new(params[:admin_login_form])
		if @form.email.present?
			administrator = Administrator.find_by(email: @form.email)
		end
		if Admin::Authenticator.new(administrator).authenticate(@form.password)
			session[:administrator_id] = administrator.id
			session[:last_access_time] = Time.current
			flash.notice = 'ログインしました'
			redirect_to :admin_root
		else
			flash.now.alert =
				if administrator.try(:suspended?)
					'アカウントが停止されています'
				else
					'メールアドレスが間違っています'
				end
			render 'new'
		end
	end

	def destroy
		session.delete(:administrator_id)
		flash.notice = 'ログアウトしました'
		redirect_to :admin_root
	end
end