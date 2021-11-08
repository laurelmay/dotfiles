#!/usr/bin/env bash

install_pyenv_deps() (
    sudo apt update
    sudo apt install make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
)

install_neovim() (
    sudo apt update
    sudo apt install neovim
)

install_base_deps() (
    sudo apt install git ansible 
)

run_ansible() (
    ansible-playbook -i hosts -t common local.yml
)

main () (
    install_base_deps
    install_neovim
    install_pyenv_deps
    run_ansible
)

main "$@"