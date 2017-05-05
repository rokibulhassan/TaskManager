require 'rails_helper'

RSpec.describe User, type: :model do
  context "with valid data" do
    subject(:user) { FactoryGirl.create(:user) }

    it 'should create user' do
      expect(user.class).to eq(User)
    end

    it 'should return expected data' do
      expect(user.email).to eq("user@gmail.com")
    end
  end

  context "with invalid data" do
    subject(:user) { FactoryGirl.create(:user, email: 'invalid') }

    it 'raise error, invalid email' do
      expect { user.save! }.to raise_error("Validation failed: Email is invalid")
    end
  end

end
