# Based on bira zsh theme with nvm, rvm and jenv support
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

local user_host='%{$terminfo[bold]$fg[green]%}%n@%m%{$reset_color%}'
local current_dir='%{$terminfo[bold]$fg[blue]%}%~%{$reset_color%}'

local nvm_node='%{$fg[green]%}$(nvm_prompt_info)%{$reset_color%}'
local pyenv_py='%{$fg[blue]%}$(virtualenv_prompt_info)%{$reset_color%}'
local aws_info='%{$fg[yellow]%}$(aws_prompt_info)%{$reset_color%}'

local git_branch='$(git_prompt_info)'

show_nvm() {
  if ! command -v nvm &> /dev/null; then
    return 1
  fi
  if nvm alias default | grep -q "$(nvm version)"; then
    return 1
  fi
  return 0
}

build_prompt_info() {
  echo -n '╭─ '
  if [ "$DEFAULT_USER" != "$USER" ]; then
    echo -n "${user_host} "
  fi
  echo -n "${current_dir} "
  echo -n "${git_branch}"
  echo -n "${nvm_node}"
  echo -n "${pyenv_py}"
  echo -n "${aws_info}"
  echo -n '\n'
  echo -n '╰─ '
  echo -n '%B[%T] %#%b '
}

PROMPT="$(build_prompt_info)"
RPS1="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=") %{$reset_color%}"
ZSH_THEME_NVM_PROMPT_PREFIX="‹node-"
ZSH_THEME_NVM_PROMPT_SUFFIX="› "
ZSH_THEME_VIRTUALENV_PREFIX="‹"
ZSH_THEME_VIRTUALENV_SUFFIX="› "
ZSH_THEME_AWS_PROFILE_PREFIX="‹󰸏 "
ZSH_THEME_AWS_PROFILE_SUFFIX="› "
