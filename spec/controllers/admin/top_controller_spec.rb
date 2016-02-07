require "rails_helper"

describe Admin::TopController do
	let(:administrator) { create(:administrator) }

	before do
		session[:administrator_id] = administrator.id
		session[:last_access_time] = 1.second.ago
	end

	describe "#index" do
		example '停止フラグが存在する場合、強制ログアウト' do
			administrator.update(suspended: true)
			get :index
			expect(session[:administrator_id]).to be_nil
			expect(response).to redirect_to(:admin_root)
		end

		example 'セッションタイムアウト' do
			session[:last_access_time] = 70.minutes.ago.advance(second: -1)
			get :index
			expect(session[:administrator_id]).to be_nil
			expect(response).to redirect_to(:admin_login)
		end
	end
end