class DropTableFailedJobs < ActiveRecord::Migration[6.1]
  def change
    drop_table :table_failed_jobs
  end
end
