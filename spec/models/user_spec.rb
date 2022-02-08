require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do

    it "should create a valid user if all fields are provided" do
      @user = User.new(name: "Franklin Saint", email: "fsaint@gmail.com", password: "snowfall", password_confirmation: "snowfall")
      expect(@user).to be_valid
    end

    it "is not valid when name field is empty" do
      @user = User.new(name: nil, email: "fsaint@gmail.com", password: "snowfall", password_confirmation: "snowfall")
      expect(@user).to_not be_valid
    end

    it "is not valid when email field is empty" do
      @user = User.new(name: "Franklin Saint", email: nil, password: "snowfall", password_confirmation: "snowfall")
      expect(@user).to_not be_valid
    end

    it "is not valid when password is empty" do
      @user = User.new(name: "Franklin Saint", email: "fsaint@gmail.com", password: nil, password_confirmation: "snowfall")
      expect(@user).to_not be_valid
    end

    it "is not valid when password confirmation is empty" do
      @user = User.new(name: "Franklin Saint", email: "fsaint@gmail.com", password: "snowfall", password_confirmation: nil)
      expect(@user).to_not be_valid
    end

    it "is not valid when password and confirmation do not match" do
      @user = User.new(name: "Franklin Saint", email: "fsaint@gmail.com", password: "snowfall", password_confirmation: "ozark")
      expect(@user).to_not be_valid
    end

    it "is not valid when email already exists in userbase" do
      @user = User.new(name: "Franklin Saint", email: "fsaint@gmail.com", password: "snowfall", password_confirmation: "snowfall")
      expect(@user).to be_valid
      @user.save!

      @user2 = User.new(name: "Fred Saint", email: "fsaint@gmail.com", password: "idkidkidk", password_confirmation: "idkidkidk")
      expect(@user2).to_not be_valid
    end

    it "is not valid when password is less than 6 characters" do
      @user = User.new(name: "Franklin Saint", email: "fsaint@gmail.com", password: nil, password_confirmation: "snoww")
      expect(@user).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do

    it 'should return user if authentication is succesful' do
      @user = User.new(name: 'Earn Marks', email: 'earn@gmail.com', password: 'atlanta', password_confirmation: 'atlanta')
      @user.save
      expect(User.authenticate_with_credentials('earn@gmail.com', 'atlanta')).to eq(@user)
    end

    it 'should succesfully login a user' do
      @user = User.create(name: 'Alfred Miles', email: 'alfredmiles@gmail.com', password: 'paperboy', password_confirmation: 'paperboy')
      expect(User.authenticate_with_credentials('alfredmiles@gmail.com', 'paperboy')).to eq(@user)
    end

    it 'should return nil and not login if provided user email is incorrect' do
      @user = User.create(name: 'Alfred Miles', email: 'alfredmiles@gmail.com', password: 'paperboy', password_confirmation: 'paperboy')
      expect(User.authenticate_with_credentials('notalfred@gmail.com', 'paperboy')).to eq(nil)
    end

    it 'should return nil and not login if provided user password is incorrect' do
      @user = User.create(name: 'Alfred Miles', email: 'alfredmiles@gmail.com', password: 'paperboy', password_confirmation: 'paperboy')
      expect(User.authenticate_with_credentials('alfredmiles@gmail.com', 'iforget')).to eq(nil)
    end

    it 'should succesfully login a user regardless of any leading/trailing whitespaces in email field' do
      @user = User.create(name: 'Alfred Miles', email: 'alfredmiles@gmail.com', password: 'paperboy', password_confirmation: 'paperboy')
      expect(User.authenticate_with_credentials(' alfredmiles@gmail.com  ', 'paperboy')).to eq(@user)
    end

    it 'should succesfully login a user regardless of email lettercase' do
      @user = User.create(name: 'Alfred Miles', email: 'alfredmiles@gmail.com', password: 'paperboy', password_confirmation: 'paperboy')
      expect(User.authenticate_with_credentials('AlfredMiles@gmail.com', 'paperboy')).to eq(@user)
    end
  end
end
