class FailedJob < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :error, presence: true
  validates :stack_trace, presence: true

  def self.find_last_week_failed_job
    index = 0
    sorted_failed_job = []
    while index < 8
      sorted_failed_job << { index.day.ago.utc.to_s => FailedJob.where(created_at: (index + 1).day.ago.utc..index.day.ago.utc).count }
      index += 1
    end
    sorted_failed_job
  end
end
