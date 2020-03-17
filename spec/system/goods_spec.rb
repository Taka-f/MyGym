require 'rails_helper'

describe 'Good', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:gym) { FactoryBot.create(:gym) }
  let!(:review) { FactoryBot.create(:review, user: user, gym: gym) }

  context 'click good button', js: true, retry: 5 do
    before do
      sign_in_as(user)
      visit gym_path(gym)
    end

    # 役に立つボタンが押せること
    it 'able to click good button' do
      wait_for_ajax do
        find('.thumbs-up-gray').click
        expect(page).to have_css '.thumbs-up-blue'
        expect(page).to have_css "#good_buttons_#{review.id}", text: '1'
      end
    end

    # 役立つボタンが解除できること
    it 'able to delete good button' do
      wait_for_ajax do
        find('.thumbs-up-gray').click
        find('.thumbs-up-blue').click
        expect(page).to have_css '.thumbs-up-gray'
        expect(page).to have_css "#good_buttons_#{review.id}", text: '0'
      end
    end
  end
end