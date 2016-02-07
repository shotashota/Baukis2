require 'rails_helper'

describe "ルーティング" do
	example '職員ページ' do
		expect(get: 'http://baukis.example.com').to route_to(
			host: 'baukis.example.com',
			controller: 'staff/top',
			action: 'index'
		)
	end

	example '管理者ページ' do
		expect(get: 'http://baukis.example.com/admin').to route_to(
			host: 'baukis.example.com',
			controller: 'admin/top',
			action: 'index'
		)
	end

	example '顧客ページ' do
		expect(get: 'http://example.com/mypage').to route_to(
			host: 'example.com',
			controller: 'customer/top',
			action: 'index'
		)
	end

	example '管理者ログインフォーム' do
		expect(get: 'http://baukis.example.com/admin/login').to route_to(
			host: 'baukis.example.com',
			controller: 'admin/sessions',
			action: 'new'
		)
	end

	example 'host名が対象外ならerrors/not_foundへ' do
		expect(get: 'http://foo.example.com').to route_to(
			controller: 'errors',
			action: 'routing_error'
		)
	end

	example '存在しないパスならerrors/not_foundへ' do
		expect(get: 'http://baukis.example.com/xyz').to route_to(
			controller: 'errors',
			action: 'routing_error',
			anything: 'xyz'
		)
	end
end