desc "Test discord webhooks"
task discord_webhooks: :environment do
  client = Discordrb::Webhooks::Client.new(url: ENV["DISCORD_WEBHOOKS"])
  client.execute do |builder|
    builder.content = "Discord bot run !"
    builder.add_embed do |embed|
      embed.title = "Test heroku bot message"
    end
  end
end
