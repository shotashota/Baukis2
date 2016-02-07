require 'rails_helper'

describe '#password' do
	example 'hashed_passwordは長さ６０' do
		administrator = Administrator.new
		administrator.password = 'test'
		expect(administrator.hashed_password.size).to eq(60)
	end

	example 'passwordがstring以外ならばhashed_passwordはnil' do
		administrator = Administrator.new
		administrator.password = 12
		expect(administrator.hashed_password).to be_nil

		administrator.password = nil
		expect(administrator.hashed_password).to be_nil
	end
end