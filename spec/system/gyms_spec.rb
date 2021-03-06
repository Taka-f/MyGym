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
    it 'able to delete gym', js: true, retry: 5 do
      visit gym_path(gym)
      wait_for_ajax do
        within '#gym-info' do
          click_on "削除"
        end
        
        expect {
          expect(page.driver.browser.switch_to.alert.text).to eq "本当に削除してもよろしいですか？"
          page.driver.browser.switch_to.alert.accept
          expect(page).to have_content "#{gym.name}の投稿を削除しました"
        }.to change{ Gym.count }.by(-1)
      end
    end
    # ジムを検索できること
    context 'search' do
      before do
        visit root_path
      end
      it 'able to find gym from name' do
        click_on 'あなたに合ったジムを探す'
        fill_in '店名で探す', with: gym.name
        click_on '検索'
        expect(page).to have_content gym.name
      end

      it 'able to find gym from area' do
        click_on 'あなたに合ったジムを探す'
        select '福岡', from: 'q_area_id_eq'
        click_on '検索'
        expect(page).to have_content '福岡'
      end

      it 'able to find gym from tag' do
        click_link "ジムを投稿"
        fill_in "店名", with: "search-gym"
        fill_in "住所", with: "東京都杉並区方南1-13"
        select "福岡", from: 'area_id'
        attach_file "gym[pictures][]", "#{Rails.root}/spec/fixtures/test.jpeg"
        check '24時間営業'
        click_button "投稿"
        visit root_path
        click_on 'あなたに合ったジムを探す'
        check '24時間営業'
        click_on '検索'
        expect(page).to have_content 'search-gym'
      end

      it 'when it does not have finding page' do
        click_on 'あなたに合ったジムを探す'
        check 'ビジター有り'
        click_on '検索'
        expect(page).to have_content '該当するジムはみつかりませんでした'
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

  context 'it not to be login user' do
    before do
      visit root_path
    end
    # ログインしてないユーザーはジムの投稿ができないこと
    it 'unabele to post new gym' do
      expect(page).to have_no_content 'ジムを投稿'
    end
  end
end
