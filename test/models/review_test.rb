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

require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
