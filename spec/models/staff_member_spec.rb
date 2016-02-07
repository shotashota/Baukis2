require 'rails_helper'
describe StaffMember do
	describe "#password=" do
		example '文字列を与えると、hashed_passwordの長さ60の文字列になる' do
			member = StaffMember.new
			member.password = 'baukis'
			expect(member.hashed_password).to be_kind_of(String)
			expect(member.hashed_password.size).to eq(60)
		end

		example 'nilを与えると、hashed_passwordはnilになる' do
			member = StaffMember.new
			member.password = nil
			expect(member.hashed_password).to be_nil
		end
	end

	describe "値の正規化" do
		example 'email前後の空白を除去' do
			member = create(:staff_member, email: ' test@example.com ')
			expect(member.email).to eq('test@example.com')
		end

		example 'emailに含まれる全角英数字を半角に変換' do
			member = create(:staff_member, email: 'ｔest@example.com')
			expect(member.email).to eq('test@example.com')
		end

		example 'email前後に含まれる全角スペースを削除' do
			member = create(:staff_member, email: "\u{3000}test@example.com\u{3000}")
			expect(member.email).to eq('test@example.com')
		end

		example 'family_name_kanaに含まれるひらがなをカタカナに変換' do
			member = create(:staff_member, family_name_kana: 'てすと')
			expect(member.family_name_kana).to eq('テスト')
		end

		example 'family_name_kanaに含まれる半角カナを全角カナに変換' do
			member = create(:staff_member, family_name_kana: 'ﾃｽﾄ')
			expect(member.family_name_kana).to eq('テスト')
		end

		example '長音符を含むfamily_name_kanaは有効' do
			member = create(:staff_member, family_name_kana: 'エリー')
			expect(member.valid?).to be_truthy
		end

		example 'メールアドレスがほかの職員と重複した場合はエラー' do
			member1 = create(:staff_member)
			member2 = build(:staff_member, email: member1.email)
			expect(member2.valid?).to be_falsey
		end
	end
end
