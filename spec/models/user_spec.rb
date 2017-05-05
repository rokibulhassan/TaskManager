require 'rails_helper'

RSpec.describe User, type: :model do
  context "with valid data" do
    it 'should create user with default information' do
      user = FactoryGirl.create(:user)
      expect(user.class).to eq(User)
    end

    it 'should create user with custom information' do
      user = FactoryGirl.create(:user, email: "rakib@gmail.com")
      expect(user.email).to eq("rakib@gmail.com")
    end
  end

  context "with invalid data" do
    it 'should not create user invalid data' do
      expect { FactoryGirl.create(:user, email: 'invalid') }.to raise_error("Validation failed: Email is invalid")
    end
  end

end
