class CreateGyms < ActiveRecord::Migration[5.1]
  def change
    create_table :gyms do |t|
      t.string :name
      t.text :description
      t.string :number
      t.string :address

      t.timestamps
    end
  end
end
