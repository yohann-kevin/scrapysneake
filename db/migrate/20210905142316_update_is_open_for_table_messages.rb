class UpdateIsOpenForTableMessages < ActiveRecord::Migration[6.1]
  def change
    change_column :messages, :is_open, :boolean, :default => false
  end
end
