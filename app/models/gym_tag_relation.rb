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

class GymTagRelation < ApplicationRecord
  belongs_to :gym
  belongs_to :tag
end
