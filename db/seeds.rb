User.create!(name:  "guest",
             email: "guest@guest.com",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

10.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

5.times do |n|
  company = Faker::Company.name
  name = Faker::Name.name
  phone = Faker::PhoneNumber.cell_phone
  email = Faker::Internet.email
  Client.create!(company: company,
                 name: name,
                 phone: phone,
                 email: email)
end
