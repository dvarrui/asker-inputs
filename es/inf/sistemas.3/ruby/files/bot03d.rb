#!/usr/bin/env ruby
require 'telegram/bot'

# token:
# 1. Write your TOKEN value into "token" variable or
# 2. Create a local file "hiden.token" with your TOKEN value inside
token =%x[cat /etc/bot03/token].strip
bot_username = '@bot03'

puts "[INFO] Running bot #{$0}..."

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    puts " => #{message.text}"
    if message.text == "/hello"
      bot.api.send_message(chat_id: message.chat.id, text: "Hello Word!")
    elsif message.text == "/byebye"
      bot.api.send_message(chat_id: message.chat.id, text: "Bye bye!")
    elsif message.text == "/help"
      bot.api.send_message(chat_id: message.chat.id, text: 'Comandos útiles:
      /hello -> ¡Hola!
      /byebye -> ¡Adiós!
      /users -> Muestra los usuarios del sistema
      /currentuser -> Usuario actual
      /ping -> Hace ping a 8.8.8.8')
    elsif message.text == "/users"
	    users = `passwd -S -a | cut -d" " -f1`
	    bot.api.send_message(chat_id: message.chat.id, text: "#{users}")
    elsif message.text == "/currentuser"
	    user = `whoami`
	    bot.api.send_message(chat_id: message.chat.id, text: "#{user}")
	  elsif message.text == "/ping"
	    ping = `ping 8.8.8.8 -c4`
      bot.api.send_message(chat_id: message.chat.id,
        text: "Haciendo PING...#{ping}")
    end
  end
end
