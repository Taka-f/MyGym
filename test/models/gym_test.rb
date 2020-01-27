# == Schema Information
#
# Table name: gyms
#
#  id          :bigint           not null, primary key
#  address     :string
#  description :text
#  likes_count :integer
#  name        :string
#  number      :string
#  picture     :string
#  time        :string
#  url         :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  area_id     :integer
#  user_id     :integer
#

require 'test_helper'

class GymTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
