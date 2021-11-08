require 'factory_bot'

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    password { 'aaaaaaaa' }
    password_confirmation { password }
    role { Role.create({ name: 'Author', description: 'Can read and create articles. Can update and destroy own articles' }) }
  end

  factory :admin, class: 'user' do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    password { 'aaaaaaaa' }
    password_confirmation { password }
    role { Role.create({ name: 'Admin', description: 'Can perform any CRUD operation on any resource' }) }
  end
end
