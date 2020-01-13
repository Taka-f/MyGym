# == Schema Information
#
# Table name: reviews
#
#  id         :bigint           not null, primary key
#  comment    :text
#  rating     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  gym_id     :integer
#  user_id    :integer
#

class Review < ApplicationRecord
  belongs_to :gym
  belongs_to :user

  validates :comment, presence: true
  validates :rating, presence: true
end
