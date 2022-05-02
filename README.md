# Dotfiles

These are a collection of my dotfiles that can be installed with Ansible. This
does not install any required packages, nor are those documented yet. This does
not overwrite any existing files and it will fail if the files already exist.

```
curl -sL https://kylelaker.com/kylelaker.asc | gpg --import
ansible-playbook -i hosts -t common local.yml
```
