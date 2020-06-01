# frozen_string_literal: true

FactoryBot.define do
  factory :appointment do
    date Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :default)
    location { Faker::Date.forward(days: 10) }
    tutor_id nil
    canceled false
  end
end
