#!/bin/bash
#
# Source: github.com/kiedtl/fetchutils/blob/master/src/mem.sh
# mem - get memory usage information
# (c) Kiëd Llaentenn <kiedtl@tilde.team>
# See the COPYING file for copyright information.
# modernized it, so that it now changes color of foreground to take attention on mem

get_mem_linux() {
	while IFS=: read -r set data; do
		data="${data%%kB}"

		case "$set" in
		MemTotal)
			kb_used=$((kb_used += data))
			kb_total=$((kb_total = data))
			;;

		Shmem)
			kb_used=$((kb_used += data))
			;;

		MemFree | Buffers | Cached | SReclaimable)
			kb_used=$((kb_used -= data))
			;;
		esac
	done </proc/meminfo

	b_used=$((kb_used * 1024))
	b_total=$((kb_total * 1024))
	mb_used=$((kb_used / 1024))
	mb_total=$((kb_total / 1024))
	gb_used=$((mb_used / 1024))
	gb_total=$((mb_total / 1024))

	b_free=$((b_total - b_used))
	kb_free=$((kb_total - kb_used))
	mb_free=$((mb_total - mb_used))
	gb_free=$((gb_total - gb_used))
}

get_mem_freebsd() {
	b_total=$(sysctl -n hw.physmem)

	pagesize="$(sysctl -n hw.pagesize)"
	inactive="$(($(sysctl -n vm.stats.vm.v_inactive_count) * pagesize))"
	unused="$(($(sysctl -n vm.stats.vm.v_free_count) * pagesize))"
	cache="$(($(sysctl -n vm.stats.vm.v_cache_count) * pagesize))"

	b_free="$((inactive + unused + cache))"
	b_used=$((b_total - b_free))
	kb_used=$((b_used / 1024))
	kb_total=$((b_total / 1024))
	mb_used=$((kb_used / 1024))
	mb_total=$((kb_total / 1024))
	gb_used=$((mb_used / 1024))
	gb_total=$((mb_total / 1024))

	kb_free=$((b_free / 1024))
	mb_free=$((kb_free / 1024))
	gb_free=$((mb_free / 1024))
}

case "$(uname -s)" in
Linux*) get_mem_linux ;;
FreeBSD*) get_mem_freebsd ;;

*)
	echo "unsupported os: $(uname -s)"
	exit 1
	;;
esac

if [[ $mb_used -lt 4000 ]]; then
	echo "%{F#fbf1c7}$mb_used MiB"
elif [[ $mb_used -lt 10000 ]]; then
	echo "%{F#fabd2f}$mb_used MiB"
elif [[ $mb_used -lt 20000 ]]; then
	echo "%{F#fe8019}$mb_used MiB"
else
	echo "%{F#fb4934}$mb_used MiB"
fi
