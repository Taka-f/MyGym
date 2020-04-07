require 'rails_helper'

describe 'Users', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let!(:user2) { FactoryBot.create(:user, name: 'user2', email: 'user2@mail.com', password: '000000') }
  # 新規登録ができること
  it 'create new user' do
    visit root_path
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

  # 登録済みのユーザーがログインできること
  it 'able to login' do
    visit root_path
    click_on 'ログイン'
    fill_in 'メールアドレス', with: 'user2@mail.com'
    fill_in 'パスワード', with: '000000'
    click_button 'ログイン'
    expect(page).to have_content "ログインしました。"
  end

  # ログインユーザーがログアウトできること
  it 'able to logout' do
    sign_in_as(user)
    visit root_path
    click_on 'ログアウト'
    expect(page).to have_content "ログアウトしました。"
  end

  # 登録されてないデータではログインできないこと
  it 'unable to login invalid data' do
    visit root_path
    click_on 'ログイン'
    fill_in 'メールアドレス', with: 'user@mail.com'
    fill_in 'パスワード', with: '123456'
    click_button 'ログイン'
    expect(page).to have_content "メールアドレスまたはパスワードが違います。"
  end
  # context 'login with Facebook' do
  #   before do
  #     OmniAuth.config.mock_auth[:facebook] = nil
  #     Rails.application.env_config['omniauth.auth'] = facebook_mock
  #     visit root_path
  #     click_on 'ログイン'
  #   end
    
  #   it 'should succeed', js: true do
  #     expect{
  #       click_on 'Facebookでログイン'
  #     }.to change(User, :count).by(1)
  #     expect(page).to have_content 'Facebookアカウントによる認証に成功しました。'
  #   end
  # end
end
