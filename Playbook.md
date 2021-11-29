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

#### Installation
```
sudo pacman -Syu gdb-dashboard
echo "source /usr/share/gdb-dashboard/.gdbinit" >>~/.config/gdb/gdbinit
```

#### Documentation
```
help dashboard
```

#### Setup
```
dashboard -enabled on
```

### User-defined commands

```
define print_stack
  set $base = $rbp
  set $size = 0

  if $argc >= 1
    set $base = $arg0
  end
  if $argc == 2
    set $size = $arg1
  end

  #printf "Using base = 0x%0lx\n", $base

  set $prev_rip = $base + 8
  set $prev_rbp = $base

  printf "previous rip @ %#016x is %#016x\n", $prev_rip, *(long*)($prev_rip)
  printf "previous rbp @ %#016x is %#016x\n", $prev_rbp, *(long*)($prev_rbp)

  eval "x /%dgx %#lx", -($size), $base
```

## Resources
| Link | Description |
| --- | --- |
| [CFI directives in assembly files](https://www.imperialviolet.org/2017/01/18/cfi.html) | DWARF introduction |
