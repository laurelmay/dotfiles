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

run_ansible() (
  ansible-playbook -i hosts -t base -t vim local.yml
)

main () (
  sudo dnf update -y
  install_base_deps
  install_neovim
  install_pyenv_deps
  run_ansible
)

main "$@"
