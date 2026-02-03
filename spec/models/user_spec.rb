require "rails_helper"

RSpec.describe User, type: :model do
  describe "バリデーション" do
    it { is_expected.to have_secure_password }

    it "email_address が必須であること" do
      user = build(:user, email_address: nil)
      expect(user).not_to be_valid
    end

    it "email_address がユニークであること" do
      create(:user, email_address: "test@example.com")
      user = build(:user, email_address: "test@example.com")
      expect(user).not_to be_valid
    end

    it "password が必須であること" do
      user = User.new(email_address: "test@example.com", password: "", password_confirmation: "")
      expect(user).not_to be_valid
    end
  end

  describe "アソシエーション" do
    it { is_expected.to have_many(:sessions).dependent(:destroy) }
  end

  describe "normalizes" do
    it "email_address を小文字に正規化すること" do
      user = create(:user, email_address: " TEST@EXAMPLE.COM ")
      expect(user.email_address).to eq("test@example.com")
    end
  end
end
