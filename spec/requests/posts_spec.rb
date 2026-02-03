require "rails_helper"

RSpec.describe "Posts", type: :request do
  let(:user) { create(:user) }

  before { sign_in_as(user) }

  describe "GET /posts" do
    it "returns http success" do
      get posts_path
      expect(response).to have_http_status(:success)
    end

    it "displays posts" do
      create(:post, title: "Test Post")
      get posts_path
      expect(response.body).to include("Test Post")
    end
  end

  describe "GET /posts/:id" do
    let(:existing_post) { create(:post) }

    it "returns http success" do
      get post_path(existing_post)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /posts/new" do
    it "returns http success" do
      get new_post_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /posts" do
    let(:valid_attributes) { { title: "New Post", body: "New Body" } }

    it "creates a new post" do
      expect do
        post posts_path, params: { post: valid_attributes }
      end.to change(Post, :count).by(1)
    end

    it "redirects to the created post" do
      post posts_path, params: { post: valid_attributes }
      expect(response).to redirect_to(Post.last)
    end
  end

  describe "PATCH /posts/:id" do
    let!(:existing_post) { create(:post) }

    it "updates the post" do
      patch post_path(existing_post), params: { post: { title: "Updated Title" } }
      existing_post.reload
      expect(existing_post.title).to eq("Updated Title")
    end
  end

  describe "DELETE /posts/:id" do
    let!(:existing_post) { create(:post) }

    it "deletes the post" do
      expect do
        delete post_path(existing_post)
      end.to change(Post, :count).by(-1)
    end
  end

  describe "認証" do
    it "未ログインでアクセスするとリダイレクトされる" do
      delete session_path
      get posts_path
      expect(response).to redirect_to(new_session_path)
    end
  end
end
