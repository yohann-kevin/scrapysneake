class AddDefaultValue < ActiveRecord::Migration[6.1]
  def change
    change_column :sneakers, :wanted, :integer, :default => 0
  end
end
