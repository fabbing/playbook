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

Walk the stack using frame pointers and print saved RIP and RBP.
```
define print_frame
    set $pf_base = $rbp

    if $argc == 1
        set $pf_base = $arg0
    end

    set $pf_prev_rip = $pf_base + 8
    set $pf_prev_rbp = $pf_base

    printf "saved rip @ %#016x is ", $pf_prev_rip
    output *(void**)($pf_prev_rip)
    printf "\n"

    printf "saved rbp @ %#016x is %#016x\n", $pf_prev_rbp, *(void**)($pf_prev_rbp)
end

define print_stack
    set $ps_base = $rbp
    set $ps_size = ($rbp - $rsp) / 8

    if $argc == 2
        set $ps_base = $arg0
        set $ps_size = $arg1
    end

    eval "x /%dgx %#lx", -($ps_size), $ps_base
end

define walk_stack
    set $ws_base = $rbp

    if $argc == 1
        set $ws_base = $arg0
    end

    while $ws_base != 0
        print_frame $ws_base
        set $ws_base = *(void**)$ws_base
    end
end
```

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
