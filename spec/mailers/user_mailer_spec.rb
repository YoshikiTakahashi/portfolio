RSpec.describe UserMailer, type: :mailer do
  let(:user) { FactoryBot.create(:user) }

  describe "password_reset" do
    let(:mail) { UserMailer.password_reset(user) }

    it "renders the headers" do
      user.reset_token = User.new_token
      expect(mail.to).to eq ["user@example.com"]
      expect(mail.from).to eq ["noreply@example.com"]
      expect(mail.subject).to eq "Password reset"
    end

    it "renders the body" do
      user.reset_token = User.new_token
      expect(mail.body.encoded).to match user.reset_token
      expect(mail.body.encoded).to match CGI.escape(user.email)
    end
  end
end
