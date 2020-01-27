class AddNumcountToGym < ActiveRecord::Migration[5.1]
  def change
    add_column :gyms, :likes_count, :integer
  end
end
