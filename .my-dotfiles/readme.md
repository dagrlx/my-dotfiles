# My dotfiles

(config para nushell)

Variable $nu.home-path es el equivalente a $HOME en zsh

## Setup

```sh
# Se inicializa en repo
git init --bare $nu.home-path/.my-dotfiles  # Se inicializa en repo
# Se crea el alias en config.nu
alias dots = ^git --git-dir=$"($nu.home-path)/.my-dotfiles" --work-tree=($nu.home-path)
# Define la ruta del repo a usar en github
dots remote add origin git@github.com:dagrlx/my-dotfiles.git
```

## Configuración

```sh
# Oculta archivos no rastreados en 'git status'
dots config status.showUntrackedFiles no
# Verifica si se aplicó la config
dots config --get status.showUntrackedFiles
# Configurar el enlace de tu repositorio de dotfiles.
dots remote set-url origin git@github.com:dagrlx/my-dotfiles.git
# Para verificar si el cambio de url se aplico
dots remote -v

```

## Método 1 (Recomendado)

## Replicación sin archivo en $home

# Para usar este método se debe de asegurar de que no existe ningún

# archivo/directorio en $HOME de los del repo, sino dará error.

```sh
 # Clona el repo bare en una nueva máquina
git clone --bare git@github.com:dagrlx/my-dotfiles.git $nu.home-path//.my-dotfiles
# Se crea el alias en config.nu
alias dots = ^git --git-dir=$"($nu  .home-path)/.my-dotfiles" --work-tree=($nu.home-path)
# Coloca los dotfiles en el nuevo sistema en su respectiva ubicación
dots checkout
# Oculta archivos no rastreados
dots config status.showUntrackedFiles no

# Nota:
# Si ocurre un conflicto se puedo forzar la sobreescritura ejecutando **dots checkout -f**
# sino se recomienda respaldar la info y luego volver el comando y/o borrar los archivos
```

## Método 2 (No establece un verdadero repo git)

## Replicacion cuando existe algun archivo en $home

# Este método evita que ocurra un error en caso de haber en $HOME

# un archivo/directorio del repo que colisione

```sh
# Clona el repo bare en una nueva máquina
git clone --separate-git-dir=$nu.home-path/.my-dotfiles git@github.com:dagrlx/my-dotfiles.git my-dotfiles-tmp
rsync --recursive --verbose --exclude '.git' my-dotfiles-tmp/ $nu.home-path/
rm --recursive my-dotfiles-tmp
```

## Comandos de uso

```sh
dots status  # Muestra el estado de los archivos
dots commit -m 'Add gitignore'
dots push origin main
dots log --oneline --graph --decorate   # Visualiza el historial con formato gráfico
dots diff   # Muestra diferencias con el último commit
dots pull origin main   # Obtiene cambios desde el repo remoto
```

## Borrar archivos y directorio

```sh
dots rm --cached -r name_file # Elimina el archivo del repo pero lo mantiene en local
# Nota: "*.nbk" de esta forma se evita la expansión de patrón.
dots rm -r name_directory   # Borra un directorio completamente del repositorio y localmente
```
