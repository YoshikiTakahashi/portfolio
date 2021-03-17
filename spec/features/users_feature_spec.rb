RSpec.describe UsersController, type: :feature do
  describe "GET /new" do
    before do
      visit new_user_path
    end

    let(:submit) { "Create my account" }

    describe "カラムが入力されていない" do
      it "ユーザーが作成されない" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "カラムが入力されている" do
      it "ユーザーが作成される" do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "password"
        fill_in "Confirmation", with: "password"
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end

  describe "GET /edit" do
    before do
      @user = User.create!(name: "Example User", email: 'user@example.com', password: 'password')
      visit login_path
      fill_in "Email", with: "user@example.com"
      fill_in "Password", with: "password"
      click_button "Log in"
      visit edit_user_path(@user)
    end

    let(:submit) { "Save changes" }

    describe "プロフィール編集" do
      it "編集されない" do
        fill_in "Name",         with: ""
        fill_in "Email",        with: "foo@invalid"
        fill_in "Password",     with: "foo"
        fill_in "Confirmation", with: "bar"
        click_button submit
        expect(current_path).to eq user_path(@user)
        expect(@user.name).to eq 'Example User'
        expect(@user.email).to eq 'user@example.com'
        expect(@user.password).to eq 'password'
      end
    end

    it "編集される" do
      fill_in "Name",         with: "Example change"
      fill_in "Email",        with: "change@example.com"
      fill_in "Password",     with: "change"
      fill_in "Confirmation", with: "change"
      click_button submit
      expect(current_path).to eq user_path(@user)
      expect(page).to have_content "Profile updated"
    end
  end
end
