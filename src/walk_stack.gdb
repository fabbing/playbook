define print_frame
	set $pf_base = $rbp

	if $argc == 1
		set $pf_base = $arg0
	end

	set $pf_prev_rip = $pf_base + 8
	set $pf_prev_rbp = $pf_base

	printf "saved rip @ %#016lx is ", $pf_prev_rip
	output *(void**)($pf_prev_rip)
	printf "\n"

	printf "saved rbp @ %#016lx is %#016lx\n", $pf_prev_rbp, *(void**)($pf_prev_rbp)
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

	printf "current rip is "
	output (void*)($rip)
	printf "\n"
	
	while $ws_base != 0
		print_frame $ws_base
		set $ws_base = *(void**)$ws_base
	end
end
