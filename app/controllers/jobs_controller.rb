class JobsController < ApplicationController
  skip_before_action :authorized

  # get last week failed job
  def last_week_failed_job
    jobs = FailedJob.find_last_week_failed_job

    render json: jobs
  end
end
