class DiscordSchedulerService
  def self.send_scheduler_message
    client = Discordrb::Webhooks::Client.new(url: ENV["DISCORD_WEBHOOKS"])
    client.execute do |builder|
      builder.content = 'Scheduler run !'
      builder.add_embed do |embed|
        embed.title = "Heroku scheduler"
        embed.description = "Scheduler good works !"
        embed.timestamp = Time.now
      end
    end
  end
end
