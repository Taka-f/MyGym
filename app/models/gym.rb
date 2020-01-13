# == Schema Information
#
# Table name: gyms
#
#  id          :bigint           not null, primary key
#  address     :string
#  description :text
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

class Gym < ApplicationRecord
  belongs_to :user
  belongs_to :area
  has_many :reviews
  mount_uploader :picture, PictureUploader
  validate :picture_size
  validates :picture, presence: true
  validates :name, presence: true
  validates :address, presence: true
private

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "5MB以上の画像は添付できません")
    end
  end
end
