FactoryBot.define do
  factory :appointment do
    date { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :default) }
    location { Faker::Lorem.word }
    tutor_id { nil }
    canceled { false }
  end
end
