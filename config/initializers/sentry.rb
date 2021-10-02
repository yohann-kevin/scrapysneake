Sentry.init do |config|
  config.breadcrumbs_logger = [:active_support_logger]
  config.background_worker_threads = 0
  config.send_default_pii = true
  config.traces_sample_rate = 1
  config.dsn = 'https://54a0e749a9d44c70b9e13f834b713908@o1023113.ingest.sentry.io/5989423'
  config.release = `git branch --show-current`
  # config.capture_exception_frame_locals = true
end
