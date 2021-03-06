RSpec.describe "Users", type: :feature do
  describe "GET /new" do
    before do
      @user = User.new(name: "Example User", email: "user@example.com")
    end
  end
end
