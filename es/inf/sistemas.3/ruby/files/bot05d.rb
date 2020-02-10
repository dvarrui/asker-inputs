#!/usr/bin/env ruby
require 'telegram/bot'

token = `cat /etc/bot05/hide.token`.strip
bot_username = '@bot05'
puts "[INFO] Running bot #{$0}..."

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    options = message.text.split(" ")

    if message.text == "/start"
      bot.api.send_message(chat_id: message.chat.id, text:
        "¿Qué puede hacer este bot?
        Bot_LawD17 es un bot que que se encarga
        de dar iformacion de una maquina operativa.

        --Para ver las opciones que puede realizar usa /help
        ")
    elsif message.text == "/help"
      bot.api.send_message(chat_id: message.chat.id, text:
        "Tu puede controlarme realizando las siguientes acciones:
        /ip - Te muestro la ip actual del equipo.
        /hostname - Muestro el nombre de la máquina.
        /hdd - Muestro información de los discos duros.
        /conection - Muestra si la maquina tiene conexión a internet.
        /install PROGRAMNAME - Instala un programa.")
    elsif options[0] == "/install"
      bot.api.send_message(chat_id: message.chat.id,
        text:"[INFO] Realizando instalación de #{options[1]}.")
      ok = system("apt-get install -y #{options[1]}")
      if ok
        bot.api.send_message(chat_id: message.chat.id,
          text:"Se ha instalado el programa.")
      else
        bot.api.send_message(chat_id: message.chat.id,
          text:"Ha ocurrido un problema.")
      end
    elsif message.text == "/ip"
      items = `ip a | grep 'inet ' | grep -v 'host lo'`.split
      bot.api.send_message(chat_id: message.chat.id,
        text: "La ip actual de la máquina es #{items[1]}")
    elsif message.text == "/hostname"
      hostname = `hostname -d`
      bot.api.send_message(chat_id: message.chat.id, text: hostname)
    elsif message.text == "/hdd"
      hdd = `df -hT | grep '/home'`.split
      bot.api.send_message(chat_id: message.chat.id, text:
      " Datos del home del equipo:
      S.fichero #{hdd[0]}
      Tipo:  #{hdd[1]}
      Tamaño:  #{hdd[2]}
      Usados:  #{hdd[3]}
      Disp:  #{hdd[4]}
      Uso%:  #{hdd[5]}
      Montado:  #{hdd[6]}
      ")
    elsif message.text == "/conection"
      ok = system('ping -c1 8.8.4.4 > /dev/null')
      if ok
        bot.api.send_message(chat_id: message.chat.id, text:"Si hay internet.")
      else
        bot.api.send_message(chat_id: message.chat.id, text:"No hay internet.")
      end
    end
  end
end
