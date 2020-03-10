# == Schema Information
#
# Table name: reviews
#
#  id         :bigint           not null, primary key
#  comment    :text(65535)
#  good_count :integer
#  rating     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  gym_id     :integer
#  user_id    :integer
#
require 'rails_helper'
# RSpec.describe Gym, type: :model do
RSpec.describe Review, type: :model do

  # FactoryBotのテスト
  it 'has a vaild FactoryBot' do
    expect(build(:review)).to be_valid
  end

  # バリデーションのテスト
  describe 'validations' do
    it 'is invalid without review comment' do
      review = build(:review, comment: nil)
      review.valid?
      expect(review.errors[:comment]).to include('を入力してください')
    end

    it 'is invalid without review rating' do
      review = build(:review, rating: nil)
      review.valid?
      expect(review.errors[:rating]).to include('を入力してください')
    end

    it 'is invalid comment length 300 over' do
      review = build(:review, comment: 'a' * 301)
      review.valid?
      expect(review.errors[:comment]).to include('は300文字以内で入力してください')
    end
  end
end
