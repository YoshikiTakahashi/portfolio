RSpec.describe SessionsController, type: :feature do
  describe "GET /new" do
    before do
      User.create!(name: "Example User", email: 'user@example.com', password: 'password')
    end

    it "ログイン/ログアウトが成功する" do
      visit login_path
      fill_in "Email", with: "user@example.com"
      fill_in "Password", with: "password"
      click_button "Log in"
      expect(page).to have_content 'ログインしました！'
      click_link "Log out"
      expect(page).to have_content 'ログアウトしました！'
    end
  end
end
