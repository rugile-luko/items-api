require 'rails_helper'

RSpec.describe Product, type: :model do
  subject do
    Product.new(title: 'Test Title 0',
                description: 'Some description about the product',
                price: 24.3,
                status: 'Available', user_id: 1)
  end

  it 'has a title' do
    expect(subject.title).to eq('Test Title 0')
  end

  it 'has a description' do
    expect(subject.description).to eq('Some description about the product')
  end

  it 'has a price' do
    expect(subject.price).to eq(24.3)
  end

  it 'has a status' do
    expect(subject.status).to eq('Available')
  end

  it 'has a user_id' do
    expect(subject.user_id).to eq(1)
  end
end
