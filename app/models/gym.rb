class Gym < ApplicationRecord
  belongs_to :user
  belongs_to :area
  mount_uploader :picture, PictureUploader
  validate :picture_size


private

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "5MB以上の画像は添付できません")
    end
  end
end