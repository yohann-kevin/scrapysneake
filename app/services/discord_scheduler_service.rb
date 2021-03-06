class DiscordSchedulerService
  def initialize(message)
    @message = message
  end

  def send_scheduler_message
    client = Discordrb::Webhooks::Client.new(url: ENV["DISCORD_WEBHOOKS"])
    client.execute do |builder|
      builder.content = "Scheduler run !"
      builder.add_embed do |embed|
        embed.title = "Heroku scheduler"
        embed.description = @message
        embed.timestamp = Time.zone.now
      end
    end
  end
end
