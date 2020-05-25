#!/bin/bash
# strip-toolchain.sh

# Exit on errors
set -e

# Strip binaries
find $PSPDEV/bin $PSPDEV/psp/bin $PSPDEV/libexec/gcc/psp \
	-type f -not -name "*.la" \
	-print0 2>/dev/null | while IFS= read -rd '' binary ; do
	case "$(LC_ALL=C readelf -h "$binary" 2>/dev/null)" in
		*Type:*'DYN (Shared object file)'*) # Libraries (.so) or Relocatable binaries
			strip_flags="-d"
			;;
		*Type:*'EXEC (Executable file)'*) # Binaries
			strip_flags=""
			;;
		*Type:*'REL (Relocatable file)'*) # Libraries (.a) or objects
			if ar t "$binary" &>/dev/null; then # Libraries (.a)
				strip_flags="-d"
			else
				continue
			fi
			;;
		*)
			continue
			;;
	esac
	strip "$binary" $strip_flags
done

# Strip debug info from libraries
find ${PSPDEV}/lib/gcc/psp -name *.a -exec psp-strip -d {} \;
