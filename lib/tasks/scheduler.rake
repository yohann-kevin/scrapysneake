desc "test heroku scheduler"
task test_heroku_scheduler: :environment do
  puts "sending message to discord"
  DiscordScheduler.send_scheduler_message
end
