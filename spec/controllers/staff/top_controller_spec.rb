require "rails_helper"

describe Staff::TopController, 'ログイン後' do
	let(:staff_member) { create(:staff_member) }

	before do
		session[:staff_member_id] = staff_member.id
		session[:last_access_time] = 1.second.ago
	end

	describe "#index" do
		example '通常はstaff/top/indexを表示' do
			get :index
			expect(response).to render_template('staff/top/index')
		end

		example '停止フラグがセットされた場合は強制ログアウト' do
			staff_member.update(suspended: true)
			get :index
			expect(session[:staff_member_id]).to be_nil
			expect(response).to redirect_to(staff_root_url)
		end

		example 'セッションタイムアウト' do
			session[:last_access_time] = Staff::Base::TIMEOUT.ago.advance(second: -1)
			get :index
			expect(session[:staff_member_id]).to be_nil
			expect(response).to redirect_to(staff_login_url)
		end
	end
end