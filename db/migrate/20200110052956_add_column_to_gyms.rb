class AddColumnToGyms < ActiveRecord::Migration[5.1]
  def change
    add_column :gyms, :time, :string
    add_column :gyms, :url, :string
  end
end
