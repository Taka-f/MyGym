# == Schema Information
#
# Table name: gyms
#
#  id          :bigint           not null, primary key
#  address     :string(255)
#  description :text(65535)
#  likes_count :integer
#  name        :string(255)
#  number      :string(255)
#  pictures    :string(255)
#  time        :string(255)
#  url         :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  area_id     :integer
#  user_id     :integer
#

require 'rails_helper'

RSpec.describe Gym, type: :model do

  # FactoryBotのテスト
  it 'has a valid factory bot' do
    expect(build(:gym)).to be_valid
  end
  # バリデーションのテスト
  describe 'validations' do
    it "is invalid without gym name" do
      gym = build(:gym, name: nil)
      gym.valid?
      expect(gym.errors[:name]).to include('を入力してください')
    end

    it "is invalid without address" do
      gym = build(:gym, address: nil)
      gym.valid?
      expect(gym.errors[:address]).to include('を入力してください')
    end

    it "is invalid without pictures" do
      gym = build(:gym, pictures: nil)
      gym.valid?
      expect(gym.errors[:pictures]).to include('を入力してください')
    end
  end

  describe 'validate unquness' do
    # 重複した名前なら無効であること
    it "dose not allow duplicate gym name" do
      create(:gym, name: "テストジム")
      area = Area.new(id: '1')
      gym = build(:gym, name: "テストジム", area: area)
      gym.valid?
      expect(gym.errors[:name]).to include("はすでに存在します")
    end
    # 重複した住所なら無効であること
    it "dose not allow duplicate gym address" do
      create(:gym, address: "東京都杉並区方南1-13")
      area = Area.new(id: '1')
      gym = build(:gym, address: "東京都杉並区方南1-13", area: area)
      gym.valid?
      expect(gym.errors[:address]).to include("はすでに存在します")
    end
  end
end
