# Support for frame-pointer

## GDB
### Disable DWARF frame unwinding
[GDB maintenance manual](https://sourceware.org/gdb/onlinedocs/gdb/Maintenance-Commands.html)
```
maintenance set dwarf unwinders off
```

### GDB dashboard
A python script giving a nice UI to GDB that allows to exceed the 2 windows
limit (asm/regs/src) of the native TUI interace: [Github wiki](https://github.com/cyrus-and/gdb-dashboard/wiki)

```
sudo pacman -Syu gdb-dashboard
ln -s /usr/share/gdb-dashboard/.gdbinit .gdbinit
```

```
help dashboard
dashboard -enabled on
```

## Resources
| Link | Description |
| --- | --- |
| [CFI directives in assembly files](https://www.imperialviolet.org/2017/01/18/cfi.html) | DWARF introduction |
