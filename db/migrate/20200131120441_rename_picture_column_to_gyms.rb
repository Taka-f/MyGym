class RenamePictureColumnToGyms < ActiveRecord::Migration[5.1]
  def change
    rename_column :gyms, :picture, :pictures
  end
end
