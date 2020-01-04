class AddUserIdToGyms < ActiveRecord::Migration[5.1]
  def change
    add_column :gyms, :user_id, :integer
  end
end
