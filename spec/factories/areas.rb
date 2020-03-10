# == Schema Information
#
# Table name: areas
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :area do
    id { '1' }
    name { '福岡' }
  end
end
