#!/usr/bin/env ruby

require 'colorize'

option = ARGV[0]
filename = ARGV[1]

def check(f_package)
  status = `whereis #{f_package[0]} |grep bin |wc -l`.to_i
    if status == 0
      puts "#{f_package[0]} ->  (U) uninstalled".colorize(:yellow)
    elsif status == 1
      puts "#{f_package[0]} ->  (I) installed".colorize(:green)
    end

end

def install(f_package)
  status = `whereis #{f_package[0]} |grep bin |wc -l`.to_i
  action = "#{f_package[1]}".to_s

  if action == "install"
    if status == 0
      `apt-get install -y #{f_package[0]}`
      puts "#{f_package[0]} -> (I) installed".colorize(:green)
    elsif status == 1
      puts "#{f_package[0]} -> (I) ya está instalado".colorize(:green)
    end

  elsif action == "remove"
      if status == 1
        `apt-get remove -y  #{f_package[0]}`
        puts "#{f_package[0]} -> (U) uninstalled".colorize(:yellow)
      elsif status == 0
        puts "#{f_package[0]} -> (U) no está instalado".colorize(:yellow)
      end
  end
end

if option == '--help'
  puts 'Usage:
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
        atomix:remove'

elsif option == '--version'
  puts 'softwarectl versión 0.0.2'
elsif option == '--status'
  file = `cat #{filename}`
  f_lines = file.split("\n")
  f_lines.each do |a|
    f_package = a.split(":")
    check(f_package)
  end

elsif option.nil?
  puts 'Se aconseja el uso de "--help" para ver la ayuda.'

elsif option == '--run'
  user = `id -u`.to_i

  if user == 0
    file = `cat #{filename}`
    f_lines = file.split("\n")
    f_lines.each do |a|
      f_package = a.split(":")
      install(f_package)
    end

  elsif user != 0
    puts "Se necesita ser usuario root para ejecutar el script".colorize(:yellow)
    exit 1
  end
end
