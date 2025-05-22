# Nushell Environment Config File

# To load from a custom file you can use:
# source ($nu.default-config-dir | path join 'custom.nu')

$env.XDG_CONFIG_HOME = ([$nu.home-path, ".config"] | path join)

# Primero carga las variables de Nix
source ~/.config/nushell/nix-env.nu

# Config de path para homebrew
$env.PATH = ($env.PATH | split row (char esep) | prepend '/opt/homebrew/bin' | prepend '/opt/homebrew/sbin')

zoxide init nushell | save -f ~/.config/nushell/zoxide.nu

#use $"($nu.home-path)/.x-cmd.root/local/data/nu/rc.nu" *; # boot up x-cmd

const ___X_CMD_ROOT = '/Users/dgarciar'; source '/Users/dgarciar/.x-cmd.root/local/data/nu/rc.nu'; # boot up x-cmd

### Carapace config
$env.CARAPACE_BRIDGES = 'zsh,bash' # optional
#mkdir ~/.cache/carapace
mkdir ~/.config/nushell/carapace
#carapace _carapace nushell | save --force ~/.cache/carapace/init.nu
carapace _carapace nushell | save --force ~/.config/nushell/carapace/carapace.nu


