# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  gym_id     :bigint
#  user_id    :bigint
#
# Foreign Keys
#
#  fk_rails_...  (gym_id => gyms.id)
#  fk_rails_...  (user_id => users.id)
#

class Like < ApplicationRecord
  belongs_to :gym, counter_cache: :likes_count
  belongs_to :user
  validates_uniqueness_of :gym_id, scope: :user_id
end
