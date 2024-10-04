.dotfiles
===

### Before install

* Move the following from the previous computer:
  * ~/.aws
  * ~/.config
  * ~/.local/share/fish/fish_history
  * ~/.gnupg
  * ~/.kube
  * ~/.ssh
* System Settings -> Keyboard -> Keyboard Shortcuts -> Input Sources. Enable both checkboxes.
* `xcode-select --install`
* `chmod 400 ~/.ssh/id_rsa`
´
### Install

```bash
git clone --recursive https://github.com/mistadikay/dotfiles ~/.dotfiles && bash ~/.dotfiles/install.sh
```