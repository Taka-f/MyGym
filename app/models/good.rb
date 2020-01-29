# == Schema Information
#
# Table name: goods
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  review_id  :bigint
#  user_id    :bigint
#
# Foreign Keys
#
#  fk_rails_...  (review_id => reviews.id)
#  fk_rails_...  (user_id => users.id)
#

class Good < ApplicationRecord
  belongs_to :user
  belongs_to :review, counter_cache: :good_count
  validates_uniqueness_of :review_id, scope: :user_id
end
