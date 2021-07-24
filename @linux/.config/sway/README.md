# Sway configuration

# Specific hostname configuration

By default `config` files will include

```
include $HOME/.config/sway/`hostname`/*
```

For using specific host configuratin such as `monitor.conf`

Include specific hostname config by using `mkdir -p $(hostname)` to create specific folder then append your specific configuration there for example

- Thinkpad `fn` keybinding that only on laptop
- Monitor configuration by specific computer using dotfiles
