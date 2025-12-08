# ~/.config/nu/config.nu
#
# ✅ Configuración modular de Nushell (v0.105+)
# Basado en mejores prácticas: https://www.nushell.sh/book/configuration.html
#
# Esta es la única entrada. Todo lo demás se carga desde subdirectorios.

# ────────────────────────────────────────────────
# 🌐 VARIABLES DE ENTORNO (Best Practice: aquí, no en env.nu)
# ────────────────────────────────────────────────

### Carapace config
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir ~/.cache/carapace
mkdir ~/.config/nushell/integrations/carapace
#carapace _carapace nushell | save --force ~/.cache/carapace/init.nu
carapace _carapace nushell | save --force ~/.config/nushell/integrations/carapace/carapace-init.nu

# Variables para el entorno nix
#nix-env.nu

# PATH: Añadir Homebrew y binarios locales sin duplicados
$env.PATH = ($env.PATH | split row (char esep)) ++ [
  "/opt/homebrew/bin"
  "/opt/homebrew/sbin"
  ($nu.home-path | path join ".local/bin")
] | uniq

# Variables específicas
$env.STARSHIP_CONFIG = ($nu.home-path | path join ".config/starship/starship.toml")
$env.GHOSTTY_CONFIG = ($nu.home-path | path join ".config/ghostty/config")
$env._ZO_ECHO = 1

# Nix-related (opcional)
$env.NIX_PROFILES = "/nix/var/nix/profiles/default /run/current-system/sw"
$env.NIX_PATH = "darwin-config=$HOME/.nix-darwin darwin=flake:nix-darwin"

# LS_COLORS (si usas bat, ls con colores)
#$env.LS_COLORS = (fetch https://raw.githubusercontent.com/trapd00r/LS_COLORS/master/LS_COLORS | str from)

# ────────────────────────────────────────────────
# ⚙️ CONFIGURACIÓN DE NUSHELL (`$env.config`)
# ────────────────────────────────────────────────

# Editor
$env.config.buffer_editor = "nvim"

# Modo vi
$env.config.edit_mode = "vi"

# Historial en SQLite
$env.config.history.file_format = "sqlite"

# Protocolo Kitty (mejor soporte de teclas)
# A keyboard enhancement protocol supported by the Kitty Terminal. Additional keybindings are
# available when using this protocol in a supported terminal. For example, without this protocol,
# Ctrl+I is interpreted as the Tab Key. With this protocol, Ctrl+I and Tab can be mapped separately.
$env.config.use_kitty_protocol = true

# Completados
# algorithm (string): Either "prefix" or "fuzzy"
$env.config.completions.algorithm = "fuzzy"

# Definir abreviaciones (zsh-abbr style)
# Expande alias o elementos en abbreviations presionando ç o enter
# https://github.com/nushell/nushell/issues/5552#issuecomment-2113935091
let abbreviations = {
    "cd..": 'cd ..'
    sau: 'sudo apt update; sudo apt upgrade'
    #bwu: 'brew update; brew upgrade; sketchybar --trigger brew_update'
}

# Menú de abreviaciones (para zsh-abbr style)
$env.config.menus = [
  {
    name: "abbreviations_menu"
    only_buffer_difference: false
    marker: "💡 "
    type: {
      layout: columnar
      columns: 1
      col_width: 20
      col_padding: 2
    }
    style: {
      text: green
      selected_text: green_reverse
      description_text: yellow
    }
    source: {|buffer, position|
      let alias_match = (scope aliases | where name == $buffer)

      if ($alias_match | is-empty) {
        let abbr_match = $abbreviations | columns | where $it == $buffer
        if ($abbr_match | is-empty) {
          []
        } else {
          [{ value: ($abbreviations | get $abbr_match.0) }]
        }
      } else {
        $alias_match | each { |it|
          let expansion = $it.expansion
          if ($expansion | str starts-with 'do {') {
            { value: ($expansion | str replace -r '^do\s*\{\s*(.*?)\s*\}$' '$1') }
          } else {
            { value: $expansion }
          }
        }
      }
    }
  }
]

# Keybindings para activar el menú de abreviaciones
$env.config.keybindings = [
  {
    name: abbreviations_menu
    modifier: none
    keycode: enter
    mode: [emacs, vi_normal, vi_insert]
    event: [
      { send: menu name: abbreviations_menu }
      { send: enter }
    ]
  }
  {
    name: abbreviations_menu
    modifier: none
    keycode: char_ç
    mode: [emacs, vi_normal, vi_insert]
    event: [
      { send: menu name: abbreviations_menu }
      { edit: insertchar value: ' ' }
    ]
  }
]

# Prompt minimalista
$env.config.show_banner = "short"

# ────────────────────────────────────────────────
# 🔌 INTEGRACIONES EXTERNAS (autoload)
# ────────────────────────────────────────────────
# Carga primero los módulos funcionales que definen comandos y hooks
source ~/.config/nushell/integrations/zoxide.nu
source ~/.config/nushell/integrations/direnv.nu
source ~/.config/nushell/integrations/broot_shell.nu
source ~/.config/nushell/integrations/aichat_shell.nu
# Luego los que afectan el prompt o historial
source ~/.config/nushell/integrations/starship.nu
source ~/.config/nushell/integrations/atuin-init.nu
# Finalmente los que afectan completado externo
source ~/.config/nushell/integrations/carapace/carapace-init.nu

# Completados adicionales
# # Completadores para comandos externos
source ~/.config/nushell/completions/zoxide-cmp.nu
# Completadores para funciones internas (cd, cdi)
source ~/.config/nushell/completions/zoxide-complete2.nu

# ────────────────────────────────────────────────
# 📦 FUNCIONES PERSONALIZADAS
# ────────────────────────────────────────────────
source ~/.config/nushell/functions/extras.nu

# ────────────────────────────────────────────────
# 🧩 ALIASES GLOBALES
# ────────────────────────────────────────────────
alias pipreset = do {jq '.vivaldi.pip_placement.left = 0 | .vivaldi.pip_placement.top = 0' $"($env.HOME)/Library/Application Support/Vivaldi/Default/Preferences"
  | save --force $"($env.HOME)/Library/Application Support/Vivaldi/Default/Preferences"}


# ─── 🧩 ALIASES: SISTEMA ─────────────────────────────
# alias la =  ls -la | select name type mode user group size modified | update modified {format date "%Y-%m-%d %H:%M:%S"}
alias la = do { ls -la | select name type mode user group size modified | update modified {format date "%Y-%m-%d %H:%M:%S"} }
# Lista archivos y directorios en formato árbol con detalles
alias lt = eza --tree --level=2 --long --icons --git
alias bcp0 = brew cleanup --prune=0
alias ngc = nix-collect-garbage -d
alias sgc = sudo nix-collect-garbage -d
alias dlg = darwin-rebuild --list-generations
alias yu = ya pkg upgrade
alias zsh-nuoff = do { NO_NU=1 zsh }
# Fuzzy finder de ventanas (Aerospace)
alias ff = do {
  aerospace list-windows --all \
    | fzf --bind 'enter:execute(bash -c "aerospace focus --window-id {1}")+abort'
}
# ─── 🧩 ALIASES: DESARROLLO ──────────────────────────
alias j = just -f ~/.config/nix-darwin/Justfile -d ~/.config/nix-darwin/
alias cat = bat
alias v = nvim
alias vn = do { NVIM_APPNAME=nvim-dev bob run nightly }
alias urldecode = python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'
alias urlencode = python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'
alias devpod = zsh -ci "open -n /Applications/DevPod.app"
alias k = kubectl
alias trivy = docker run --rm -v trivy-cache:/root/.cache/ -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy:latest
# Abrir tmux limpio
alias tmux-nu = do { tmux kill-server | complete; tmux }
# Alias para fzf + nvim
alias fzn = do {fzf --preview '''bat --style=numbers --color=always {}''' | xargs -n1 nvim}

# ─── 🧩 ALIASES: RED/SSH ─────────────────────────────
alias sshp = ssh -o ProxyJump=sabaext
alias sshtp = env TERM=xterm-256color ssh -o ProxyJump=sabaext
alias ssht = env TERM=xterm-256color ssh

# ─── 🧩 ALIASES: GIT ─────────────────────────────────
alias gp = git push origin main
alias dots = ^git --git-dir ($nu.home-path | path join ".my-dotfiles") --work-tree $nu.home-path



# scripts for unzip
use scripts/extractor.nu extract
