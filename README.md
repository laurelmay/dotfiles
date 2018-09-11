# Dotfiles

These are a collection of my dotfiles that can be installed with Ansible. This
does not install any required packages, nor are those documented yet. This does
not overwrite any existing files and it will fail if the files already exist.

To run this playbook you can either use `ansible-playbook` or `ansible-pull`.
If you want to only install common things pass the common tag, to include
desktop & X11 stuff pass the `desktop` tag.

To run on all hosts:

```
ansible-playbook -i hosts -t common local.yml
```
