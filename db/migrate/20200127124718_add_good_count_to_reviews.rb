class AddGoodCountToReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :good_count, :integer
  end
end
