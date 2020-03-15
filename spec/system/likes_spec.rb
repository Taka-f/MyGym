require 'rails_helper'

describe "Likes", type: :system do 
  let!(:user) { FactoryBot.create(:user) }
  let!(:gym) { FactoryBot.create(:gym) }

  context "Click Like button", js: true, retry: 5 do
    before do
      sign_in_as(user)
      visit gym_path(gym)
    end
    # お気に入り登録ができること
    it "user get like" do
      wait_for_ajax do
        find('.like-btn-gray').click
        expect(page).to have_css '.like-btn-red'
        expect(page).to have_css "#likes_buttons_#{gym.id}", text: '1'   
      end
    end
    # お気に入り解除できること
    it 'user delete like' do
      wait_for_ajax do
        find('.like-btn-gray').click
        find('.like-btn-red').click
        expect(page).to have_css '.like-btn-gray'
        expect(page).to have_css "#likes_buttons_#{gym.id}", text: '0'
      end
    end
  end
end