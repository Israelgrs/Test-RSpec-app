require 'rails_helper'

RSpec.describe Product, type: :model do
  it 'is valid with description, price and category' do
    product = create(:product)
    expect(product).to be_valid
  end

  context 'Validations one liner syntax with shoulda matchers' do
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:category) }
    it { is_expected.to belong_to(:category) }
  end

  context 'Validations hardcoded' do
    it 'is invalid without description' do
      product = build(:product, description: nil)
      product.valid?
      expect(product.errors[:description]).to include("can't be blank")
    end

    it 'is invalid without the price' do
      product = build(:product, price: nil)
      product.valid?
      expect(product.errors[:price]).to include("can't be blank")
    end

    it 'is invalid without category' do
      product = build(:product, category: nil)
      product.valid?
      expect(product.errors[:category]).to include("can't be blank")
    end
  end

  context 'instance methods' do
    it '#full_description - return a product with a full description' do
      product = create(:product)
      expect(product.full_description).to eq("#{product.description} - #{product.price}")
    end
  end
end
