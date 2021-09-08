class DropSites < ActiveRecord::Migration[6.1]
  def change
    drop_table :sites
  end
end
