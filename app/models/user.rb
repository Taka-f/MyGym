# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  image                  :string
#  name                   :string
#  provider               :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  uid                    :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ApplicationRecord
  has_many :gyms
  has_many :reviews
  has_many :goods
  has_many :likes
  has_many :liked_gyms, through: :likes, source: :gym
  mount_uploader :image, PictureUploader

  def already_liked?(gym)
    self.likes.exists?(gym_id: gym.id)
  end

  def already_good?(review)
    self.goods.exists?(review_id: review.id)
  end
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook twitter google_oauth2]
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.remote_image_url = auth.info.image.gsub("_normal","") if user.provider == "twitter"
      user.remote_image_url = auth.info.image.gsub("picture","picture?type=large") if user.provider == "facebook"
      user.remote_image_url = auth.info.image if user.provider == "google_oauth2"
      user.password = Devise.friendly_token[0,20]
    end
  end

end
