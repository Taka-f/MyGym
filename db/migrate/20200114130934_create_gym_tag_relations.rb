class CreateGymTagRelations < ActiveRecord::Migration[5.1]
  def change
    create_table :gym_tag_relations do |t|
      t.references :gym, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
  end
end
