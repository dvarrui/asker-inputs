#!/usr/bin/env ruby

# Muestra mensaje de error
def empty_arguments	
  print("Comando ejecutado sin argumentos, para mas ayuda ejecuta 'systemctl --help'\n")
end

# Muestra la ayuda
def show_help
  print("Usage:
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
        atomix:remove\n")
end

# Muestra la información del script
def show_info	
  print("softwarectl version 0.0.3\n")
end

# Lee el archivo que se adjunta
def get_file	
  filename = ARGV[1]
  file_splited = File.read(filename).split(/\W+/)
  return file_splited
end

# Obtiene el nombre de los programas
def get_programs	
  file_splited = get_file
  programs = []
  x = 0
  while x < file_splited.length
    programs.push(file_splited[x])
    x += 2
  end
  print programs
  return programs
end

# Obtiene la acción a realizar con los programas (Instalar o borrar)
def get_action		
  file_splited = get_file
  action = []
  x = 1
  while x < file_splited.length
    action.push(file_splited[x])
    x += 2
  end
  print action
  return action
end

# Indica si los programas están instalados o no
def get_status
  programs = get_programs
  installed = {}
  programs.each do |a|
    exit = `whereis #{a} |grep bin |wc -l`.to_i
    if exit == 1		
      installed[a] = "installed"
    else
      installed[a] = "uninstalled"
    end
  end		
  print installed
end

# Hace la instalación o desinstalación de los programas
def do_installation 	
  user_id = `id -u`.to_i
  if user_id == 0
    programs = get_programs
    action = get_action
    x = 0
    while x < programs.length
      if action[x] == "install"
        `apt install -y #{programs[x]}`
      elsif action[x]== "remove"
        `apt remove -y #{programs[x]}`
      else
        print("Una de las acciones no tiene el formato correcto")
      end
      x += 1
    end
  else
    print ("Es necesario ser root para ejecutar el argumento --run\n")
  end
end 

def show_menu
  option = ARGV[0] 
  if option == nil
    empty_arguments  
  elsif option == "--help"
    show_help
  elsif option == "--version"
    show_info
  elsif option == "--status"
    get_status
  elsif option == "--run"
    do_installation
  else
    print ("Uso inadecuado del comando\n")
  end
end

show_menu
