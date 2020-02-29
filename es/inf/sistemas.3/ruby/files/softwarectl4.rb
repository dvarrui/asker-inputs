#!/usr/bin/env ruby

puts 'Bienvenido a softwarectl'

if ARGV[0] == nil
  puts "Recomendamos el uso de --help"
elsif ARGV[0] == '--help'
  puts '
Usage:
   systemctml [OPTIONS] [FILENAME]
Options:
   --help, mostrar esta ayuda.
   --version, mostrar informacion sobre el autor del script
              y fecha de creacion.
   --status FILENAME, comprueba si puede instalar/desintalar.
   --run FILENAME, instala/desinstala el software indicado.
Description:

   Este script se encarga de instalar/desinstalar
   el software indicado en el fichero FILENAME.
   Ejemplo de FILENAME:
   tree:install
   nmap:install
   atomix:remove
  '
elsif ARGV[0] == '--version'
  puts 'softwarectl version 0.0.4'
elsif ARGV[0] == '--status' and ARGV[1]

  filename = `cat #{ARGV[1]}`
  lines = filename.split("\n")
  lines.each do |line|
    fields = line.split(":")
    param1 = `whereis #{fields[0]} |grep bin |wc -l`.chop
    if param1 == "1"
      puts "Paquete #{fields[0]} : SI esta instalado"

    elsif param1 == "0"
       puts "Paquete #{fields[0]} : NO esta instalado"

     end
  end

elsif ARGV[0] == '--run'

  param1 = `whoami`.chop
  if param1 == 'root'
    filename = `cat #{ARGV[1]}`
    lines = filename.split("\n")
    lines.each do |line|
      fields = line.split(":")
      if fields[1] == 'install'
        puts "Instalando paquete #{fields[0]}..."
        `zypper install -y #{fields[0]}`
      elsif fields[1]== 'remove'
        puts "Eliminando paquete #{fields[0]}..."
        `zypper remove -y #{fields[0]}`
      end
    end
  elsif param1 != 'root'
    puts "Usted no tiene permisos de administrador"
  end
end
