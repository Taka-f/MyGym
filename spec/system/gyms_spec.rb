require 'rails_helper'

describe "Gyms", type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:user2) { FactoryBot.create(:user, name: 'user2') }
  let!(:gym) { FactoryBot.create(:gym, area: area, user: user) }
  let!(:area) { FactoryBot.create(:area) }
  let!(:tag) { FactoryBot.create(:tag)}

  context 'gym by main user' do
    
    # ログインユーザーが新規ジムを登録できること
    before do
      sign_in_as(user)
    end
    it "user create new gym" do
      visit root_path
      expect {
        click_link "ジムを投稿"
        fill_in "店名", with: "testgym"
        fill_in "住所", with: "東京都杉並区方南1-13"
        select "福岡", from: 'area_id'
        attach_file "gym[pictures][]", "#{Rails.root}/spec/fixtures/test.jpeg"
        check '24時間営業'
        check 'マシン充実'
        check 'シャワー有り'
        click_button "投稿"
  
        expect(page).to have_content "testgymを投稿しました"
      }.to change(user.gyms, :count).by(1)
    end
    # 投稿内容が変更できること
    it 'edit gym information' do
      visit edit_gym_path(gym)
      fill_in "店名", with: "testgym2"
      fill_in "住所", with: "東京都杉並区方南1-14"
      fill_in "詳細", with: "詳細内容を変更"
      click_button "投稿"
      expect(page).to have_content "testgym2の投稿を編集しました"
      expect(page).to have_content "東京都杉並区方南1-14"
      expect(page).to have_content "詳細内容を変更"
    end
  
    # 投稿を削除できること
    it 'able to delete gym', js: true do
      visit gym_path(gym)
      within '#gym-info' do
        click_on "削除"
      end
      expect {
        expect(page.driver.browser.switch_to.alert.text).to eq "本当に削除してもよろしいですか？"
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content "#{gym.name}の投稿を削除しました"
      }.to change{ Gym.count }.by(-1)
    end
    # ジムを検索できること
    context 'search' do
      it 'able to find gym' do
        visit root_path
        click_on 'あなたに合ったジムを探す'
        fill_in '店名で探す', with: gym.name
        click_on '検索'
        expect(page).to have_content gym.name
      end
    end
  end

  context 'gym by another user' do
    before do
      sign_in_as(user2)
    end
    # 他のユーザーが編集、削除できないこと
    it 'unable to edit and delete by another user' do
      visit gym_path(gym)
      expect(page).to have_no_content '編集'
      expect(page).to have_no_content '削除'
    end
  end
end
