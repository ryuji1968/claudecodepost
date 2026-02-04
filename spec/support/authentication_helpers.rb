module AuthenticationHelpers
  module SystemHelpers
    def sign_in_as(user)
      visit new_session_path
      fill_in "メールアドレス", with: user.email_address
      fill_in "パスワード", with: "password"
      click_button "ログイン"
      expect(page).to have_content("ダッシュボード")
    end
  end

  module RequestHelpers
    def sign_in_as(user)
      post(session_path, params: { email_address: user.email_address, password: "password" })
    end
  end
end

RSpec.configure do |config|
  config.include AuthenticationHelpers::SystemHelpers, type: :system
  config.include AuthenticationHelpers::RequestHelpers, type: :request
end
