class CreateTableFailedJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :table_failed_jobs do |t|
      t.string :name
      t.string :description
      t.string :error
      t.string :stack_trace
      t.timestamps
    end
  end
end
