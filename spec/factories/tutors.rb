# frozen_string_literal: true

FactoryBot.define do
  factory :tutor do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    subject { Faker::Lorem.word }
    about { Faker::Lorem.paragraph }
  end
end
