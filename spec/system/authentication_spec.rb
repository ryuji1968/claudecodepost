require "rails_helper"

RSpec.describe "認証", type: :system do
  let(:user) { create(:user, email_address: "test@example.com") }

  describe "ログイン" do
    it "ログインできる" do
      visit new_session_path

      fill_in "メールアドレス", with: user.email_address
      fill_in "パスワード", with: "password"
      click_button "ログイン"

      expect(page).to have_content("ダッシュボード")
    end

    it "不正な認証情報でログインできない" do
      visit new_session_path

      fill_in "メールアドレス", with: user.email_address
      fill_in "パスワード", with: "wrong_password"
      click_button "ログイン"

      expect(page).to have_content("メールアドレスまたはパスワードが正しくありません")
    end
  end

  describe "ログアウト" do
    it "ログアウトできる" do
      sign_in_as(user)

      find(".header-profile-btn").click
      click_button "ログアウト"

      expect(page).to have_content("ログイン")
    end
  end

  describe "新規登録" do
    it "新規登録できる" do
      visit new_registration_path

      fill_in "メールアドレス", with: "newuser@example.com"
      fill_in "user_password", with: "password"
      fill_in "user_password_confirmation", with: "password"
      click_button "登録する"

      expect(page).to have_content("ダッシュボード")
      expect(page).to have_content("アカウントを作成しました")
    end
  end

  describe "認証保護" do
    it "未ログインはログイン画面にリダイレクトされる" do
      visit posts_path

      expect(page).to have_content("ログイン")
      expect(page).to have_current_path(new_session_path)
    end
  end
end
