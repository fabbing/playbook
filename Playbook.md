# Support for frame-pointer

## OCaml

### Disable inlining
[Language extensions / Attributes](https://ocaml.org/manual/attributes.html)

```ocaml
let [@inline never] foo () =
	...
```

## GDB

### Disable DWARF frame unwinding
[GDB maintenance manual](https://sourceware.org/gdb/onlinedocs/gdb/Maintenance-Commands.html)
```
maintenance set dwarf unwinders off
```

### Custom user-defined commands

Walking the stack using frame pointers and print saved RIP and RBP with
[walk_stack](src/walk_stack.gdb)

## GDB dashboard
A python script giving a nice UI to GDB that allows to exceed the 2 windows
limit (asm/regs/src) of the native TUI interace: [Github wiki](https://github.com/cyrus-and/gdb-dashboard/wiki)

### Installation
```
sudo pacman -Syu gdb-dashboard
echo "source /usr/share/gdb-dashboard/.gdbinit" >>~/.config/gdb/gdbinit
```

### Documentation
```
help dashboard
```

### Setup
```
dashboard -enabled on
```

## Resources
| Link | Description |
| --- | --- |
| [CFI directives in assembly files](https://www.imperialviolet.org/2017/01/18/cfi.html) | DWARF introduction |
