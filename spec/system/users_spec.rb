require 'rails_helper'

describe 'Users', type: :system do
  let(:user) { FactoryBot.create(:user) }
  # 新規登録ができること
  it 'create new user' do
    visit root_path
    # visit new_user_registration_path
    expect {
      click_on '新規登録'
      fill_in '名前', with: 'user1'
      fill_in 'メールアドレス', with: 'test@mail.com'
      fill_in 'パスワード', with: 'password', match: :first
      fill_in '確認用パスワード', with: 'password'
      click_on 'アカウント登録'

      expect(page).to have_content 'アカウント登録が完了しました。'
    }.to change(User, :count).by(1)
  end
  # ユーザー情報を変更また写真を登録できること
  it 'edit user profile' do
    sign_in_as(user)
    visit root_path
    click_on 'マイページ'
    click_on 'アカウント編集'
    # visit edit_user_registration_path
    attach_file "user[image]", "#{Rails.root}/spec/fixtures/test.jpeg"
    fill_in '名前', with: 'test2'
    click_on '更新'
    expect(page).to have_content 'アカウント情報を変更しました。'
  end

  # ユーザーはアカウントを削除できること
  it 'delete user account', js: true do
    sign_in_as(user)
    # visit edit_user_registration_path
    visit root_path
    click_on 'マイページ'
    click_on 'アカウント編集'
    click_on 'アカウント削除'
    expect {
      expect(page.driver.browser.switch_to.alert.text).to eq "本当によろしいですか?"
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content "アカウントを削除しました。またのご利用をお待ちしております。"
    }.to change{ User.count }.by(-1)
  end
end