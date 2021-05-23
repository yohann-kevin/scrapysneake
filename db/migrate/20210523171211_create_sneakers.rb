class CreateSneakers < ActiveRecord::Migration[6.1]
  def change
    create_table :sneakers do |t|
      t.string :model
      t.integer :price
      t.string :link
      t.string :gender
      t.string :seller
      t.string :image_path
      t.integer :wanted

      t.timestamps
    end
  end
end
