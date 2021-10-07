class DiscordScheduler
  def initialize
    @url_webhook = ENV["DISCORD_WEBHOOKS"]
  end
  
  def send_scheduler_message
    client = Discordrb::Webhooks::Client.new(url: @url_webhook)
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
