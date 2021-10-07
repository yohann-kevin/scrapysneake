# exemple : 
# desc "test heroku scheduler"
# task test_heroku_scheduler: :environment do
#   puts "sending message to discord"
#   DiscordScheduler.send_scheduler_message
# end

desc "Scrap sneaker in foot locker"
task scrap_sneaker_foot_locker: :environment do
  msg =  "scrap sneaker in foot locker"
  puts msg
  begin
    ScraperFootlockerController.scrap_foot_locker
    DiscordSchedulerService.new(msg).send_scheduler_message
  rescue => err
    DiscordErrorService.new("scheduler", "for foot locker", err, err.backtrace.join("\n")).send_error
    raise err
  end
end

desc "Scrap man sneaker in official shop"
task scrap_man_sneaker_official_shop: :environment do
  msg = "scrap man sneaker in official_shop"
  puts msg
  begin
    ScraperOfficialshopController.scrap_officialshop("man")
    DiscordSchedulerService.new(msg).send_scheduler_message
  rescue => err
    DiscordErrorService.new("scheduler", "for man official shop", err, err.backtrace.join("\n")).send_error
    raise err
  end
end

desc "Scrap women sneaker in official shop"
task scrap_women_sneaker_official_shop: :environment do
  msg = "scrap women sneaker in official shop"
  puts msg
  begin
    ScraperOfficialshopController.scrap_officialshop("women")
    DiscordSchedulerService.new(msg).send_scheduler_message
  rescue => err
    DiscordErrorService.new("scheduler", "for women official shop", err, err.backtrace.join("\n")).send_error
    raise err
  end
end
