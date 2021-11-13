class UpdateIdSneakers < ActiveRecord::Migration[6.1]
  def change
    change_column :sneakers, :id, :string, limit: 36, primary: true
  end
end
