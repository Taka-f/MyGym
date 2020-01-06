class AddPictureToGyms < ActiveRecord::Migration[5.1]
  def change
    add_column :gyms, :picture, :string
  end
end
