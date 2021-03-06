RSpec.describe User, type: :model do
  describe 'バリデーション' do
    let(:user) { create(:user) }

    it 'nameとemailどちらも値が設定されていれば、OK' do
      expect(user.valid?).to eq(true)
    end

    it 'nameが空だとNG' do
      user.name = ''
      expect(user.valid?).to eq(false)
    end

    describe 'emailテスト' do
      it 'emailが空だとNG' do
        user.email = ''
        expect(user.valid?).to eq(false)
      end

      it "メールアドレスは一意である必要がある" do
        duplicate_user = user.dup
        user.save
        expect(duplicate_user.valid?).to eq(false)
      end

      it "user作成時にemailが小文字で作成される" do
        mixed_case_email = "User@ExAMPle.CoM"
        user.email = mixed_case_email
        user.save
        expect(user.reload.email).to eq("user@example.com")
      end
    end

    describe 'passwordテスト' do
      it 'passwordとpassword_confirmationが同一でOK' do
        user.password = user.password_confirmation
        expect(user.valid?).to eq(true)
      end

      it "空白6文字のpasswordはエラー" do
        user.password = user.password_confirmation = " " * 6
        expect(user.valid?).to eq(false)
      end

      it "5文字以下のpasswordはエラー" do
        user.password = user.password_confirmation = "a" * 5
        expect(user.valid?).to eq(false)
      end
    end
  end
end
