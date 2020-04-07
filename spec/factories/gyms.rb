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

FactoryBot.define do
  factory :gym do
    # name { 'テストジム' }
    sequence(:name) {|n| "Gym#{n}"}
    sequence(:address) {|n| "東京都杉並区方南1-13-#{n}"}
    # address { '東京都杉並区方南1-13-1' }
    number { '000-0000' }
    url { 'https://test.com' }
    time { '24時間' }
    description { 'テストジムの詳細です' }
    pictures { [Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpeg'))] }
    user
    association :area
    # association :tag
    # tag.name { '24時間営業' }
  end
end
