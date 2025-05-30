# My dotfiles

(config para nushell)

Variable $nu.home-path es el equivalente a $HOME en zsh

## Setup

```sh
# Se inicializa en repo
git init --bare $nu.home-path/.my-dotfiles
# Se crea el alias en config.nu
alias dots = ^git --git-dir=$"($nu.home-path)/.my-dotfiles" --work-tree=($nu.home-path)
# Define la ruta del repo a usar en github
dots remote add origin git@github.com:dagrlx/my-dotfiles.git
```

## Configuración

```sh
# Oculta archivos no rastreados en 'git status'
dots config --local status.showUntrackedFiles no
# Verifica si se aplicó la config
dots config --get status.showUntrackedFiles
# Configurar el enlace de tu repositorio de dotfiles.
dots remote set-url origin git@github.com:dagrlx/my-dotfiles.git
# Para verificar si el cambio de url se aplico
dots remote -v

```

## Método 1 (Recomendado)

## Replicación sin archivo en $home

```sh
# Para usar este método se debe de asegurar de que no existe ningún
# archivo/directorio en $HOME de los del repo, sino dará error.

 # Clona el repo bare en una nueva máquina
git clone --bare git@github.com:dagrlx/my-dotfiles.git $nu.home-path//.my-dotfiles
# Se crea el alias en config.nu
alias dots = ^git --git-dir=$"($nu  .home-path)/.my-dotfiles" --work-tree=($nu.home-path)
# Coloca los dotfiles en el nuevo sistema en su respectiva ubicación
dots checkout
# Oculta archivos no rastreados
dots config --local status.showUntrackedFiles no

# Nota:
# Si ocurre un conflicto se puedo forzar la sobreescritura ejecutando **dots checkout -f**
# sino se recomienda respaldar la info y luego volver el comando y/o borrar los archivos
```

## Método 2 (No establece un verdadero repo git)

## Replicacion cuando existe algun archivo en $home

```sh
# Este método evita que ocurra un error en caso de haber en $HOME
# un archivo/directorio del repo que colisione

# Clona el repo bare en una nueva máquina
git clone --separate-git-dir=$nu.home-path/.my-dotfiles git@github.com:dagrlx/my-dotfiles.git my-dotfiles-tmp
rsync --recursive --verbose --exclude '.git' my-dotfiles-tmp/ $nu.home-path/
rm --recursive my-dotfiles-tmp
```

## Comandos de uso

```sh
# Muestra el estado de los archivos
dots status
dots commit -m 'Add gitignore'
dots push origin main
# Visualiza el historial con formato gráfico
dots log --oneline --graph --decorate
# Muestra diferencias con el último commit
dots diff
# Obtiene cambios desde el repo remoto
dots pull origin main
```

## Borrar archivos y directorio

```sh
# Elimina el archivo del repo pero lo mantiene en local
dots rm --cached -r name_file
# Nota: "*.nbk" de esta forma se evita la expansión de patrón.
# Borra un archivo/directorio completamente del repositorio y localmente
dots rm -r name_file/name_directory
```
