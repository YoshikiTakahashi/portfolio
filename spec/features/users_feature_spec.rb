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
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "password"
        fill_in "Confirmation", with: "password"
      end

      it "ユーザーが作成される" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end
end
