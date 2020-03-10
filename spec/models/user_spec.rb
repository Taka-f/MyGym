# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  image                  :string(255)
#  name                   :string(255)
#  provider               :string(255)
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  uid                    :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do

  # FactoryBotのテスト
  it "has a valid factory bot" do
    expect(build(:user)).to be_valid
  end
  
  describe 'validations' do
    # 名前がなければ無効な状態であること
    it "is invalid without name" do
      user = build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include("を入力してください")
    end
    # メールアドレスがなければ無効な状態であること
    it "invalid without email" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end
    # パスワードがなければ無効な状態であること
    it "is invalid without password" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end
    # 重複したメールアドレスなら無効な状態であること
    it "is invalid with a duplicate email" do
      create(:user, email: "test@email.com")
      user = build(:user, email: "test@email.com")
      user.valid?
      expect(user.errors[:email]).to include("はすでに存在します")
    end
  end
end
