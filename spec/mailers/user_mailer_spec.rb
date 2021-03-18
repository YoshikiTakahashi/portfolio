RSpec.describe UserMailer, type: :mailer do
  let(:user) { FactoryBot.create(:user) }

  describe "account_activation" do
    # アカウント有効化メールのテストは省略
  end

  describe "password_reset" do
    let(:mail) { UserMailer.password_reset(user) }

    # メール送信のテスト
    it "renders the headers" do
      user.reset_token = User.new_token
      expect(mail.to).to eq ["user@example.com"]
      expect(mail.from).to eq ["noreply@example.com"]
      expect(mail.subject).to eq "Password reset"
    end

    # メールプレビューのテスト
    it "renders the body" do
      user.reset_token = User.new_token
      expect(mail.body.encoded).to match user.reset_token
      expect(mail.body.encoded).to match CGI.escape(user.email)
    end
  end
end
