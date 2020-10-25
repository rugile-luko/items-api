FactoryBot.define do
  factory :product do
    sequence :title do |n|
      "Product Title #{n}"
    end

    sequence :description do |n|
      "Product Description #{n}"
    end

    sequence :price do |n|
      "#{n}"
    end

    sequence :status do |n|
      "Product Status #{n}"
    end

    association :user_id, factory: :user
  end
end