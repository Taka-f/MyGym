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

class Gym < ApplicationRecord
  belongs_to :user
  belongs_to :area
  has_many :reviews, dependent: :destroy
  has_many :gym_tag_relations, dependent: :delete_all
  has_many :tags, through: :gym_tag_relations
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  mount_uploaders :pictures, PictureUploader
  serialize :pictures, JSON
  validate :picture_size
  validates :pictures, presence: true
  validates :name, presence: true, uniqueness: true
  validates :address, presence: true, uniqueness: true
  
  def self.create_like_ranks
    Gym.includes(:area).find(Like.group(:gym_id).order('count(gym_id) desc').limit(4).pluck(:gym_id))
  end

  def self.create_review_ranks
    Gym.includes(:area).find(Review.group(:gym_id).order('count(gym_id) desc').limit(4).pluck(:gym_id))
  end

  def rating_average
    if self.reviews.blank?
      average_review = 0
    else
      average_review = self.reviews.average(:rating).round(2)
    end
  end
private

  def picture_size
    if pictures.size > 5.megabytes
      errors.add(:pictures, "5MB以上の画像は添付できません")
    end
  end

  
end
