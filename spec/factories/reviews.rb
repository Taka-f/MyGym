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
FactoryBot.define do
  factory :review do
    comment { 'テスト口コミです' }
    rating { '5' }
    association :user
    association :gym
  end
end
