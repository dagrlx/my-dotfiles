# My dotfiles

## Setup
```sh
git init --bare $nu.home-path/.my-dotfiles
alias dots = ^git --git-dir=$"($nu.home-path)/.my-dotfiles" --work-tree=($nu.home-path) (for nuhell)
dots remote add origin git@github.com:dagrlx/my-dotfiles.git
```

## Configuration
```sh
dots config status.showUntrackedFiles no  # Oculta archivos no rastreados en 'git status'
dots remote set-url origin git@github.com:dagrlx/my-dotfiles.git
```

## Replication with file in $home
```sh
git clone --separate-git-dir=$nu.home-path/.my-dotfiles git@github.com:dagrlx/my-dotfiles.git my-dotfiles-tmp
rsync --recursive --verbose --exclude '.git' my-dotfiles-tmp/ $nu.home-path/
rm --recursive my-dotfiles-tmp
```

## Replication without file in $home
```sh
git clone --bare git@github.com:dagrlx/my-dotfiles.git $nu.home-path//.my-dotfiles   # Clona el repo bare en una nueva máquina
alias dots = ^git --git-dir=$"($nu.home-path)/.my-dotfiles" --work-tree=($nu.home-path) (for nuhell)
dots checkout   # Aplica los dotfiles en el nuevo sistema
dots config status.showUntrackedFiles no   # Oculta archivos no rastreados

## Usage
```sh
dots status  # Muestra el estado de los archivos
dots commit -m 'Add gitignore'
dots push origin main
dots log --oneline --graph --decorate   # Visualiza el historial con formato gráfico
dots diff   # Muestra diferencias con el último commit
dots pull origin main   # Obtiene cambios desde el repo remoto
```

## Delete files and directory
```sh
dots rm --cached -r name_file # Elimina del índice pero lo mantiene en disco
dots rm -r name_directory   # Borra un directorio completamente del repositorio
```
