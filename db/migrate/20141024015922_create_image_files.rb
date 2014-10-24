class CreateImageFiles < ActiveRecord::Migration
  def change
    create_table :image_files do |t|
      t.string :name
      t.string :height
      t.string :width

      t.timestamps
    end
  end
end
