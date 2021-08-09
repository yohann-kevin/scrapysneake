class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.string :mail
      t.string :object
      t.string :content
      t.boolean :is_open
      t.timestamps
    end
  end
end
