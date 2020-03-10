# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :tag do
    name {[
      '24時間営業',
      'ビジター有り',
      'マシン充実',
      'フリーウエイト充実',
      '駐車場有り',
      '駅近',
      'トレーナー在籍',
      'シャワー有り',
      'トライアル有り',
      'プロテインBAR',
      'タンニングマシン有り',
      '複数店舗利用可',
      'カリキュラム有り'
    ]}
    # association :gym
    # name { '24時間' }
  end
end
