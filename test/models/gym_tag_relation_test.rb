# == Schema Information
#
# Table name: gym_tag_relations
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  gym_id     :bigint
#  tag_id     :bigint
#
# Foreign Keys
#
#  fk_rails_...  (gym_id => gyms.id)
#  fk_rails_...  (tag_id => tags.id)
#

require 'test_helper'

class GymTagRelationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
