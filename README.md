# dotfiles
Quick configs i can't live without on my machines. 

```./install.sh ```
installs everything to your system

```./install.sh undo```
removes only the configs from your home directory

```./install.sh wipe```
removes both the configs and packages installed

if you find  yourself in a machine that has ansible pre-installed you could use
it too to install
```ansible-playbook install.yml --ask-become-pass```
