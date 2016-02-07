class Admin::StaffMembersController < Admin::Base
	def index
		@staff_members = StaffMember.order(:family_name_kana, :given_name_kana)
	end

	def new
		@staff_member = StaffMember.new
	end

	def create
		@staff_member = StaffMember.new(model_params)
		if @staff_member.save
			flash.notice = '職員アカウントを登録しました'
			redirect_to :admin_staff_members
		else
			render 'new'
		end
	end

	def show
		staff_member = StaffMember.find(params[:id])
		redirect_to [:edit, :admin, staff_member]
	end

	def edit
		@staff_member = StaffMember.find(params[:id])
	end

	def update
		@staff_member = StaffMember.find(params[:id])
		@staff_member.assign_attributes(model_params)
		if @staff_member.save
			flash.notice = '職員アカウントを更新しました'
			redirect_to :admin_staff_members
		else
			render 'edit'
		end
	end

	def destroy
		staff_member = StaffMember.find(params[:id])
		staff_member.destroy!
		flash.notice = '職員アカウントを削除しました。'
		redirect_to :admin_staff_members
	end

	private

	def model_params
		model = params.require(:staff_member).permit(
					:email, :password, :family_name,
					:given_name, :family_name_kana, :given_name_kana,
					:start_date, :end_date, :suspended
			)
	end
end
