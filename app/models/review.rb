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

class Review < ApplicationRecord
  belongs_to :gym
  belongs_to :user
  has_many :goods, dependent: :delete_all
  has_many :good_users, through: :goods, source: :user
  validates :comment, presence: true, length: {maximum: 300}
  validates :rating, presence: true

  def good_user(user_id)
    goods.find_by(user_id: user_id)
   end
end
