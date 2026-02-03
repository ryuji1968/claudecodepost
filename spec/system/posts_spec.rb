require "rails_helper"

RSpec.describe "Posts", type: :system do
  let(:user) { create(:user) }

  before { sign_in_as(user) }

  describe "投稿一覧" do
    it "投稿一覧を表示できる" do
      post = create(:post, title: "テスト投稿", body: "テスト本文")

      visit posts_path

      expect(page).to have_content("投稿一覧")
      expect(page).to have_content("テスト投稿")
      expect(page).to have_content("テスト本文")
    end
  end

  describe "投稿作成" do
    it "新規投稿を作成できる" do
      visit posts_path
      click_link "新規投稿"

      fill_in "タイトル", with: "新しい投稿"
      fill_in "本文", with: "これは新しい投稿の本文です。"
      click_button "登録する"

      expect(page).to have_content("投稿を作成しました。")
      expect(page).to have_content("新しい投稿")
      expect(page).to have_content("これは新しい投稿の本文です。")
    end
  end

  describe "投稿詳細" do
    it "投稿詳細を表示できる" do
      post = create(:post, title: "詳細テスト", body: "詳細本文")

      visit posts_path
      click_link "表示", match: :first

      expect(page).to have_content("詳細テスト")
      expect(page).to have_content("詳細本文")
      expect(page).to have_content("内容")
    end
  end

  describe "投稿編集" do
    it "投稿を編集できる" do
      post = create(:post, title: "編集前タイトル", body: "編集前本文")

      visit edit_post_path(post)

      fill_in "タイトル", with: "編集後タイトル"
      fill_in "本文", with: "編集後本文"
      click_button "更新する"

      expect(page).to have_content("投稿を更新しました。")
      expect(page).to have_content("編集後タイトル")
      expect(page).to have_content("編集後本文")
    end
  end

  describe "投稿削除" do
    it "投稿を削除できる" do
      post = create(:post, title: "削除対象", body: "削除される投稿")

      visit post_path(post)
      click_button "削除"
      click_button "OK"

      expect(page).to have_content("投稿を削除しました。")
      expect(page).not_to have_content("削除対象")
    end
  end
end
