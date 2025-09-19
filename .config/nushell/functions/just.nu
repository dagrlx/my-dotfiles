# ~/.config/nu/functions/j.nu
#
# Función `j`: ejecuta comandos just desde cualquier directorio.
# Requiere que el Justfile esté en ~/.config/nix-darwin

def j [
  --list (-l): true  # Muestra lista de comandos disponibles
  ...rest           # Comandos adicionales para just
] {
  # Definir rutas
  let dir = ($nu.home-path | path join ".config/nix-darwin")
  let justfile = ($dir | path join "Justfile")

  # Validar existencia del directorio
  if not ($dir | path exists) {
    error make {
      msg: "Directorio no encontrado"
      help: $"No se encontró el directorio de configuración:\n  $dir\n¿Está instalado nix-darwin?"
    }
  }

  # Validar existencia del Justfile
  if not ($justfile | path exists) {
    error make {
      msg: "Justfile no encontrado"
      help: $"No se encontró el archivo Justfile en:\n  $dir\n¿Estás usando un setup basado en flakes + just?"
    }
  }

  # Ejecutar el comando en el contexto del directorio
  do -c {
    cd $dir
    if $list and ($rest | is-empty) {
      ^just --list
    } else if ($rest | is-empty) {
      ^just --list  # Por defecto, si no hay args
    } else {
      ^just $rest
    }
  } || error make {
    msg: "Error al ejecutar 'just'"
    help: "Verifica que 'just' esté instalado y que el Justfile sea válido.\nEste comando requiere acceso a Nix y posiblemente permisos de sudo."
  }
}
