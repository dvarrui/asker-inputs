#!/usr/bin/env ruby
require 'telegram/bot'

token = `cat /etc/bot04/token`.strip
bot_username = '@bot04'

puts "[INFO] Running bot #{$0}..."

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    puts " => #{message.text}"
    if message.text == "/hello"
      bot.api.send_message(chat_id: message.chat.id,
        text: "Hello #{message.from.first_name}")
    elsif message.text == "/bye"
      bot.api.send_message(chat_id: message.chat.id,
        text: "Bye #{message.from.first_name}!")
    elsif message.text == "/map"
      bot.api.send_location(chat_id: message.chat.id,
        latitude: 28.4119142, longitude: -16.5525396)
    elsif message.text == "/help"
      bot.api.send_message(chat_id: message.chat.id,
        text: "Puedes usar los comandos:
/hello
/bye
/map
/version")
    elsif message.text == "/version"
      lines = `cat /etc/*-release`
      com_lines = lines.split("\n")
      bot.api.send_message(chat_id: message.chat.id, text: com_lines[0])
      bot.api.send_message(chat_id: message.chat.id, text: com_lines[1])
    else
      bot.api.send_message(chat_id: message.chat.id,
        text: "Utiliza un comando válido")
    end
  end
end
