FactoryBot.define do
  factory :user do
    name { "MyString" }
    email { "MyString" }
    password { "foobar" }
    password_confirmation { "foobar" }
  end
end
