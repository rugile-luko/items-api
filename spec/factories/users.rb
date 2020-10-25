FactoryBot.define do
  factory :user do
    sequence :name do |n|
      "Username#{n}"
    end

    sequence :email do |n|
      "test#{n}@example.com"
    end
  end
end
