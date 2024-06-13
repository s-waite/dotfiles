source_dir="${HOME}/.config/zsh"
plugin_dir="${HOME}/.config/zsh/plugins"
# source ${source_dir}/movement.sh
source ${source_dir}/setup.sh
source ${source_dir}/config_files.sh
source ${source_dir}/misc_alias.sh
source ${source_dir}/nnn.sh
source ${source_dir}/prompt.sh
source ${source_dir}/env_variables.sh
source ${source_dir}/functions.sh
source ${source_dir}/path.sh
source ${plugin_dir}/zsh-git-support.sh
source ${plugin_dir}/zsh-autosuggestions/zsh-autosuggestions.zsh
source ${plugin_dir}/zsh-vi-mode/zsh-vi-mode.zsh
eval "$(lua ${plugin_dir}/z.lua/z.lua --init zsh enhanced once echo)"
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
source ${plugin_dir}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


# Define an init function and append to zvm_after_init_commands, this will prevent it from overwriting keybinds
function my_init() {
  eval "$(/opt/homebrew/bin/atuin init zsh)"
}
zvm_after_init_commands+=(my_init)



export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/sam/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/sam/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/sam/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/sam/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

