desc "test heroku scheduler"
task test_heroku_scheduler: :environement do
  puts "sending message to discord"
  DiscordScheduler.send_scheduler_message
end
