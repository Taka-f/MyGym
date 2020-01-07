class Review < ApplicationRecord
  belongs_to :gym
  belongs_to :user
end
