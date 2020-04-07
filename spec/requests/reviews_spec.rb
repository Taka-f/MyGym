require 'rails_helper'

RSpec.describe "reviews", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:gym) { FactoryBot.create(:gym) }
  let!(:review) { FactoryBot.create(:review, user: user, gym: gym)}

  context 'as an authenticated user or not' do
    # ログインユーザーはレビュー投稿ページにアクセスできること
    it 'post review pages response' do
      sign_in user
      get new_gym_review_path(gym)
      expect(response).to have_http_status(200)
      expect(response).to be_success
    end
    # ゲストユーザーはレビュー投稿ページにアクセスできないこと
    it 'post review pages response' do
      get new_gym_review_path(gym)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to new_user_session_path
    end
  end
  # レビュー投稿ができ詳細ページにリダイレクトされること
  context 'with vaild attributes' do
    it 'add a review' do
      review_params = FactoryBot.attributes_for(:review)
      sign_in user
      expect {
        post gym_reviews_path(gym), params: { review: review_params }
      }.to change(Review, :count).by(1)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to gym_path(gym)
    end
  end
  # 無効なデータでは投稿できないこと
  context 'with invaild attributes' do
    it 'does not add a review' do
      review_params = FactoryBot.attributes_for(:review, rating: '')
      sign_in user
      expect {
        post gym_reviews_path(gym), params: { review: review_params }
      }.to_not change(Review, :count)
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  context 'able to edit by login user' do
    # 自分の投稿の編集ページにアクセスできること
    it 'responds successfully' do
      sign_in user
      get edit_gym_review_path(review.gym, review)
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    # 投稿内容を更新できること
    it 'able to updates by login user' do
      review_params = FactoryBot.attributes_for(:review, comment: "コメント編集")
      sign_in user
      patch gym_review_path(review.gym, review), params: { review: review_params }
      expect(review.reload.comment).to eq "コメント編集"
      expect(response).to have_http_status(302)
      expect(response).to redirect_to gym_path(gym)
    end
  end

  # ゲストユーザーは編集ページにアクセスできないこと
  context 'unable to edit by guest' do
    it 'redirects to the login page' do
      get edit_gym_review_path(review.gym, review)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to new_user_session_path
    end
  end
  # レビュー投稿ページを削除できること
  context 'able to delete own review' do
    it 'deletes by my self' do
      sign_in user
      expect {
        delete gym_review_path(review.gym, review), params: { id: review.id }
      }.to change(Review, :count).by(-1)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to gym_path(gym)
    end
  end
  # ゲストユーザーはレビュー投稿削除できないこと
  context 'unable to delete other user reviews' do
    it 'deletes review by guest' do
      expect {
        delete gym_review_path(review.gym, review), params: { id: review.id }
      }.to_not change(Review, :count)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to new_user_session_path
    end
  end
end