set -g EDITOR nvim

for file in "$HOME/.cargo/env"
  if test -f "$file"
    source "$file"
  end
end

for dir in "$HOME/go/bin" "$HOME/.poetry/bin" (ruby -e "puts Gem.user_dir")
  if test -d "$dir"
    set -x PATH $dir $PATH
  end
end

if test -d "$HOME/.pyenv"
  set -x PYENV_ROOT $HOME/.pyenv
  set -x PATH $PYENV_ROOT/bin $PATH
  status --is-interactive; and . (pyenv init -|psub)

  if test -d "$PYENV_ROOT/plugins/pyenv-virtualenv"
    status --is-interactive; and . (pyenv virtualenv-init -|psub)
  end
end
