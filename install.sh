#!/usr/bin/env bash

install_pyenv_deps() (
  sudo dnf install -y make gcc zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel tk-devel libffi-devel xz-devel
)

install_neovim() (
  sudo dnf install -y neovim
)

install_base_deps() (
  sudo dnf install -y git ansible
)

import_pgp_key() (
  curl -sL https://kylelaker.com/kylelaker.asc | gpg --import
)

run_ansible() (
  ansible-playbook -i hosts -t common local.yml
)

main () (
  sudo dnf update -y
  install_base_deps
  install_neovim
  install_pyenv_deps
  import_pgp_key
  run_ansible
)

main "$@"
