## Export gnome config

```
dconf dump /org/gnome/shell/extensions/ > some-file.txt
```

## Load gnome config

```
dconf load /org/gnome/shell/extensions/ < some-file.txt
```
