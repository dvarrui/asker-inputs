#!/usr/bin/env ruby

def show_help
  puts '
Usage:
        systemctml [OPTIONS] [FILENAME]
Options:
        --help, mostrar esta ayuda.
        --version, mostrar información sobre el autor del script
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
end

def check_filename
  if ARGV[1].nil?
    puts "[ERROR] Falta especificar el nombre del fichero!"
    exit 1
  end
end

def show_status
  check_filename
  lines = `cat #{ARGV[1]}`.split("\n")
  lines.each do |line|
    items = line.split(":")
    show_status_of_package(items[0])
  end
end

def show_status_of_package(name)
  status = `whereis #{name} |grep bin |wc -l`.to_i
    if status == 0
      puts "[INFO] Paquete #{name} instalado? NO"
    elsif status == 1
      puts "[INFO] Paquete #{name} instalado? Sí"
    end
end

def process_packages
  check_filename
  username = `whoami`.chop
  unless username == 'root'
    puts "[ERROR] Ejecutar #{$0} como administrador!"
    exit 1
  end
  lines = `cat #{ARGV[1]}`.split("\n")
  lines.each do |line|
    items = line.split(":")
    process_package(item[0], item[1])
  end
end

def process_package(name, action)
  status = `whereis #{name} |grep bin |wc -l`.to_i
  if action == "install"
    if status == 0
      puts "[INFO] Instalando #{name}..."
      `zypper install -y #{name}`
    elsif status == "1"
      puts "[ OK ] #{name} ya está instalado!"
    end
  elsif action == "remove"
    if status == 1
      puts "[INFO] Desinstalando #{name}..."
      `zypper remove -y #{name}`
    elsif status == 0
      puts "[ OK ] #{name} ya está desinstalado!"
    end
  end
end

if ARGV[0].nil?
  puts "Usage: #{$0} --help, para consultar la ayuda"
elsif ARGV[0] == '--help'
  show_help
elsif ARGV[0] == '--version'
  puts "Programa #{$0} versión 0.0.1"
elsif ARGV[0] == '--status'
  show_status
elsif ARGV[0] == '--run'
  process_packages
end
