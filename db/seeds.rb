User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

20.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

20.times do |n|
  company = Faker::Company.name
  name = Faker::Name.name
  phone = Faker::PhoneNumber.cell_phone
  email = Faker::Internet.email
  Client.create!(company: company,
                 name: name,
                 phone: phone,
                 email: email)
end
