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

require 'test_helper'

class GymTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
