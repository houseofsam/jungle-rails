require 'rails_helper'

RSpec.feature "Visitor navigates to product page", type: :feature, js: true do
  
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'
     
    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They add a product to cart and see My Cart have 1 item in the navbar" do
    visit root_path

    #ACT
    first('article.product').click_button('Add')

    #VERIFY
    expect(page).to have_content 'My Cart (1)'
    
    #DEBUG
    save_screenshot
  end
end