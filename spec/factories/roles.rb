FactoryBot.define do
  factory :role do
    name { Faker::Name.name }
    description { Faker::Lorem.paragraph(sentence_count: 10) }
  end
end
