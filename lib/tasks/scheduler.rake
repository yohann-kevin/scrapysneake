# exemple : 
# desc "test heroku scheduler"
# task test_heroku_scheduler: :environment do
#   puts "sending message to discord"
#   DiscordScheduler.send_scheduler_message
# end

desc "Scrap sneaker in foot locker"
task scrap_sneaker_foot_locker: :environment do
  puts "scrap sneaker in foot locker"
  ScraperFootlockerController.scrap_foot_locker
end

desc "Scrap man sneaker in official shop"
task scrap_man_sneaker_official_shop: :environment do
  puts "scrap man sneaker in official_shop"
  ScraperOfficialshopController.scrap_officialshop("man")
end

desc "Scrap women sneaker in official shop"
task scrap_women_sneaker_official_shop: :environment do
  puts "scrap women sneaker in official shop"
  ScraperOfficialshopController.scrap_officialshop("women")
end
