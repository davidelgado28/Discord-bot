require 'dotenv/load'
require 'discordrb'

bot = Discordrb::Commands::CommandBot.new(
  token: ENV.fetch('DISCORD_BOT_TOKEN'),
  prefix: '!'
)

bot.ready do
  puts "Bot conectado com sucesso como #{bot.profile.username}!"
end

bot.message(with_text: 'Ping!') do |event|
  event.respond 'Pong!'
end

bot.command(:dado, description: 'Rola um dado de 6 lados') do |event|
  resultado = rand(1..6)
  event.respond "#{event.user.mention} rolou o dado e tirou **#{resultado}**!"
end

bot.command(:limpar, min_args: 1, max_args: 1, required_permissions: [:manage_messages]) do |event, quantidade|
  num = quantidade.to_i
  next 'Informe um número entre 1 e 50.' unless num.between?(1, 50)

  event.channel.prune(num + 1)
  event.send_temporary_message("#{num} mensagens apagadas!", 5)
end

bot.run
