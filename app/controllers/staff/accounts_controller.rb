class Staff::AccountsController < Staff::Base
	def show
		@staff_member = current_staff_member
	end

	def edit
		@staff_member = current_staff_member
	end

	def update
		@staff_member = current_staff_member
		@staff_member.assign_attributes(model_params)
		if @staff_member.save
			flash.notice = 'アカウント情報を更新しました'
			redirect_to :staff_account
		else
			flash.now.alert = '入力が不正です'
			render action: 'edit'
		end
	end

	private

	def model_params
		params.require(:staff_member).permit!
	end
end
