require 'rails_helper'

describe 'reviews', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:user2) { FactoryBot.create(:user, name: 'user2') }
  let(:gym) { FactoryBot.create(:gym) }
  let!(:review) { FactoryBot.create(:review, user: user, gym: gym)}

  context 'reviwe by main user' do
    
    before do
      sign_in_as(user)
    end
  
    # it 'user create a review' do
    #   visit gym_path(gym)
    #   expect {
    #     click_link '口コミを投稿'
    #     find('#rating-form', visible: false).set(5.0)
    #     fill_in 'コメント', with: 'テスト口コミ'
    #     click_button '投稿'
    #     expect(page).to have_content '口コミを投稿しました'
    #   }.to change(Review, :count).by(1)
    # end

    # ジムの詳細ページにて口コミが確認できること
    it 'able to see the review on gym page' do
      visit gym_path(gym)
      expect(page).to have_content review.comment
      expect(page).to have_content review.rating
    end

    it 'able to see the review on my page' do
      click_on 'マイページ'
      expect(page).to have_content review.comment
    end

    # レビューしたユーザーネームが確認できること
    it 'abele to see the review user name' do
      visit gym_path(gym)
      expect(page).to have_content user.name
    end

    # レビュー件数が確認できること
    it 'able to see the reviews count' do
      visit root_path
      expect(page).to have_content '1件のレビュー'
    end
  
    # 口コミの削除ができること
    it 'able to delete the review', js: true, retry: 5 do
      visit gym_path(gym)
      wait_for_ajax do
        within '.review-edit' do
          click_on '削除'
        end
        expect {
          expect(page.driver.browser.switch_to.alert.text).to eq "本当に削除してもよろしいですか？"
          page.driver.browser.switch_to.alert.accept
          expect(page).to have_content "口コミを削除しました"
        }.to change{ Review.count }.by(-1)
      end
    end
  end
  
  context 'review by another user' do
    before do
      sign_in_as(user2)
    end
    # 他のユーザーが口コミを削除、編集できない
    it 'unablel to delet the review by other user' do
      visit gym_path(gym)
      expect(page).to have_no_content '編集'
      expect(page).to have_no_content '削除'
    end
  end
  # ログインしてないユーザーは口コミを投稿できない
  context 'review by without login' do
    it 'unable to post review' do
      visit gym_path(gym)
      expect(page).to have_no_content '口コミを投稿'
    end
  end
end