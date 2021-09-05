class CreateTableSites < ActiveRecord::Migration[6.1]
  def change
    create_table(:sites, :id => false) do |t|
      t.string :uuid, :limit => 36, :primary => true
      t.string :name
      t.timestamps
    end
  end
end
