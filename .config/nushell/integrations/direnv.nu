# ~/.config/nu/integrations/direnv.nu
def env_direnv [] {
  ^direnv export json | from json
}

def post_execution_hook [
  engine-state: engine-state
  stack: stack
] {
  if ($stack.has-env-var 'PWD') {
    let pwd = ($stack.get-env-var 'PWD').value
    let new_pwd = (pwd | path expand)
    if not ($new_pwd == $env.PWD) {
      $env = ($env | merge (env_direnv))
      $env.PWD = $new_pwd
    }
  } {  # caso donde no existe PWD
    $env = ($env | merge (env_direnv))
    $env.PWD = (pwd | path expand)
  }
}

$env.config.hooks.post_execution_hook = {|e, s| post_execution_hook $e $s}
