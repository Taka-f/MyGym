class AddAreaIdToGyms < ActiveRecord::Migration[5.1]
  def change
    add_column :gyms, :area_id, :integer
  end
end
