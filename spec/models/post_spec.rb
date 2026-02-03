require "rails_helper"

RSpec.describe Post, type: :model do
  describe "factory" do
    it "has a valid factory" do
      expect(build(:post)).to be_valid
    end
  end

  describe "attributes" do
    it "can have a title" do
      post = create(:post, title: "Test Title")
      expect(post.title).to eq("Test Title")
    end

    it "can have a body" do
      post = create(:post, body: "Test Body")
      expect(post.body).to eq("Test Body")
    end
  end
end
