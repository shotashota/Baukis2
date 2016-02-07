require 'rails_helper'

describe Admin::Authenticator do
	describe '#authenticate' do
		example '停止フラグが立っていればfalseを返す' do
			m = build(:administrator, suspended: true)
			expect(Admin::Authenticator.new(m).authenticate('pw')).to be_falsey
		end
	end
end
