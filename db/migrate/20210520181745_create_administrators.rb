class CreateAdministrators < ActiveRecord::Migration[6.1]
  def change
    create_table :administrators do |t|
      t.string :name
      t.string :encrypted_password

      t.timestamps
    end
  end
end
