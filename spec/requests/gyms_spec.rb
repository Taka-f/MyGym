require "rails_helper"

RSpec.describe "gym pages", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:gym) { FactoryBot.create(:gym, area: area, user: user) }
  let!(:area) { FactoryBot.create(:area) }
  # 正常なレスポンスを返すこと
  context "index pages response" do
    it 'responds successfully' do
      get root_path
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end
  end
  # 正常なレスポンスを返すこと
  context 'show pages response' do
    it 'responds successfully' do
      get gym_path(gym)
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end
  end

  context 'as an authenticated user or not' do
    before do
      @user = FactoryBot.create(:user)
    end
    # ログインユーザーはジム投稿ページにアクセスできること
    context 'new pages response' do
      it 'responds successfully' do
        sign_in @user
        get new_gym_path
        expect(response).to have_http_status(200)
        expect(response).to be_success
      end
    end
    # ジム投稿ができ詳細ページにリダイレクトされること
    context 'with vaild attributes' do
      it 'add a gym' do
        gym_params = FactoryBot.attributes_for(:gym)
        sign_in @user
        expect {
          post gyms_path, params: { gym: gym_params, area_id: area.id }
        }.to change(@user.gyms, :count).by(1)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to gym_path(@user.gyms.ids)
      end
    end
    # 無効なデータでは投稿できないこと
    context 'with invalid attributes' do
      it 'does not add a gym' do
        gym_params = FactoryBot.attributes_for(:gym, name: '')
        sign_in @user
        expect {
          post gyms_path, params: { gym: gym_params, area_id: area.id }
        }.to_not change(@user.gyms, :count)
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end
    # ゲストユーザーは投稿できないこと
    context 'unable to post by guest' do
      it 'redirects to the login page' do
        get new_gym_path
        expect(response).to have_http_status(302)
        expect(response).to redirect_to new_user_session_path
      end
    end
    context 'able to edit by login user' do
      # 自分の投稿の編集ページにアクセスできること
      it 'responds successfully' do
        sign_in @user
        @gym  = FactoryBot.create(:gym, user: @user, area: area)
        get edit_gym_path(@gym)
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
      # 投稿内容を更新できること
      it 'able to updates by login user' do
        gym_params = FactoryBot.attributes_for(:gym, name: "NewGym")
        sign_in user
        patch gym_path(gym), params: { gym: gym_params, area_id: area.id }
        expect(gym.reload.name).to eq "NewGym"
        expect(response).to have_http_status(302)
        expect(response).to redirect_to gym_path(gym)
      end
    end

    # ゲストユーザーは編集ページにアクセスできないこと
    context 'unable to edit by guest' do
      it 'redirects to the login page' do
        get edit_gym_path(gym)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to new_user_session_path
      end
    end
    # 投稿ページを削除できること
    context 'able to delete own post' do
      it 'deletes by my self' do
        sign_in @user
        @gym  = FactoryBot.create(:gym, user: @user, area: area)
        expect {
          delete gym_path(@gym), params: { id: @gym.id }
        }.to change(@user.gyms, :count).by(-1)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to root_path
      end
    end
    # ゲストユーザーは投稿削除できないこと
    context 'unable to delete other user post' do
      it 'deletes post by guest' do
        expect {
          delete gym_path(gym), params: { id: gym.id }
        }.to_not change(user.gyms, :count)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end