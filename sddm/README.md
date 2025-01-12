replace background current wallpaper when run pywal
```bash
convert $(cat $HOME/.cache/wal/wal) -blur 0x20 /usr/share/sddm/themes/Elegant/background.jpg
```


test theme
```bash
sddm-greeter --test-mode --theme <theme dir>
```
