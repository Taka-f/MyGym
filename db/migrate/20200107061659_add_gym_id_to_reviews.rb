class AddGymIdToReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :gym_id, :integer
  end
end
