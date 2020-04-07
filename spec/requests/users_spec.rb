require "rails_helper"

RSpec.describe "Users", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  # 正常なレスポンスを返すこと
  context 'sign up pages response' do
    it 'responds successfully' do
      get new_user_registration_path
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end
  end
  # 正常なレスポンスを返すこと
  context 'sign in pages response' do
    it 'responds successfully' do
      get new_user_session_path
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end
  end
  #ユーザーが追加されたときの検証
  context 'valid request' do
    it 'redirect_to root_path after add a user' do
      expect {
        post user_registration_path, params: { user: attributes_for(:user) }
      }.to change(User, :count).by(1)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to root_path
    end
  end

  context 'invalid request' do
    let(:user_params) do
      attributes_for(:user, name: '',
                            email: 'user@invalid',
                            password: '1234567',
                            password_confirmation: '1234567')
    end
    #ユーザーが追加されないこと
    it 'does not add a user' do
      expect {
        post user_registration_path, params: { user: user_params }
      }.to_not change(User, :count)
    end
    # ログインできないこと
    it 'does not log in by invalid user' do
      post user_session_path, params: { user: user_params }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end
  # ログアウトできトップページにリダイレクトされること
  context 'user pages response' do
    it 'responds successfully' do
      @user = FactoryBot.create(:user)
      sign_in @user
      delete destroy_user_session_path
      expect(response).to have_http_status(302)
      expect(response).to redirect_to root_path
    end
  end
  # マイページにアクセスできること
  context 'user pages response' do
    it 'responds successfully' do
      @user = FactoryBot.create(:user)
      sign_in @user
      get user_path(id: @user.id)
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end
  end
  # ログインユーザーの場合
  context 'as login user' do
    # ユーザーを更新できること
    it "able to updates by login user" do
      user_params = FactoryBot.attributes_for(:user, name: "NewName")
      sign_in user
      patch user_registration_path, params: { id: user.id, user: user_params }
      expect(user.reload.name).to eq "NewName"
      expect(response).to have_http_status(302)
      expect(response).to redirect_to root_path
    end
  end
  # ログインしてないユーザーの場合
  context 'as a guest' do
    it 'redirect to the login page' do
      user_params = FactoryBot.attributes_for(:user, name: "NewName")
      patch user_registration_path, params: { id: user.id, user: user_params }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to new_user_session_path
    end
  end
  # アカウントが違うユーザーの場合
  context 'as other user' do
    it "unable to updates by other user" do
      user_params = FactoryBot.attributes_for(:user, name: "NewName")
      sign_in other_user
      patch user_registration_path, params: { id: user.id, user: user_params }
      expect(user.reload.name).to eq other_user.name
      expect(response).to redirect_to root_path
    end
  end

  context 'destroy' do
    # 自分のアカウントを削除できること
    it 'able to delete account by my self' do
      sign_in user
      expect {
        delete user_registration_path, params: { user: user }
      }.to change(User, :count).by(-1)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to root_path
    end
    # ゲストユーザーが他のアカウントを削除できないこと
    it 'unable to delete account by guest' do
      expect {
        delete user_registration_path, params: { user: user }
      }.to_not change(User, :count)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to new_user_session_path
    end
  end
end