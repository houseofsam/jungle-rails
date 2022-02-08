require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before do
      @category = Category.new(:name => 'Furniture')
    end

    it 'should successfully save with all four fields set' do
      @product = Product.new(:name => 'Lazy Chair', :price => 4000, :quantity => 7, :category => @category)
      @product.save!
      expect(@product).to be_present
    end

    it 'should not successfully save without a name field' do
      @product = Product.new(:price => 4000, :quantity => 7, :category => @category)
      expect(@product).to_not be_valid
      expect(@product.errors.messages[:name]).to include("can't be blank")
    end

    it 'should not successfully save without a price field' do
      @product = Product.new(:name => 'Lazy Chair', :quantity => 7, :category => @category)
      expect(@product).to_not be_valid
      expect(@product.errors.messages[:price]).to include("can't be blank")
    end

    it 'should not successfully save without a quantity field' do
      @product = Product.new(:name => 'Lazy Chair', :price => 4000, :category => @category)
      expect(@product).to_not be_valid
      expect(@product.errors.messages[:quantity]).to include("can't be blank")
    end

    it 'should not successfully save without a category field' do
      @product = Product.new(:name => 'Lazy Chair', :price => 4000, :quantity => 7)
      expect(@product).to_not be_valid
      expect(@product.errors.messages[:category]).to include("can't be blank")
    end
  end
end
