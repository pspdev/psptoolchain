#!/bin/bash

echo "Detecting OS and installing packages required for PSP Toolchain"

#Handle macOS first
if [ "$(uname -s)" = "Darwin" ]; then
  ## Check if using brew
  if command -v brew &> /dev/null; then
    brew update
	brew install gettext texinfo bison flex gnu-sed ncurses gsl gmp mpfr autoconf automake cmake libusb-compat libarchive gpgme bash openssl libtool
    brew reinstall openssl # https://github.com/Homebrew/homebrew-core/issues/169728#issuecomment-2074958306
  fi
  ## Check if using MacPorts
  if command -v port &> /dev/null; then
    sudo port install autoconf automake cmake doxygen gsed libelf libtool pkgconfig
  fi
else

    TESTOS=$(cat /etc/os-release | grep -w "ID" | cut -d '=' -f2)

    case $TESTOS in

    ubuntu | debian)
        sudo apt-get update
        sudo apt-get -y install texinfo bison flex gettext libgmp3-dev libmpfr-dev libmpc-dev libusb-dev libreadline-dev libcurl4 libcurl4-openssl-dev libssl-dev libarchive-dev libgpgme-dev \
        libz-dev	
    ;;
    rhel | fedora)
         dnf -y install @development-tools gcc gcc-c++ g++ wget git autoconf automake python3 python3-pip make cmake pkgconf \
          libarchive-devel openssl-devel gpgme-devel libtool gettext texinfo bison flex gmp-devel mpfr-devel libmpc-devel ncurses-devel diffutils \
          libusb-compat-0.1-devel readline-devel libcurl-devel which glibc-gconv-extra xz
    ;;
    gentoo)
        sudo emerge --noreplace net-misc/wget dev-vcs/git dev-python/pip sys-apps/fakeroot \
                                        app-arch/libarchive app-crypt/gpgme sys-devel/bison sys-devel/flex\
                                        dev-libs/mpc dev-libs/libusb-compat
    ;;
    arch)
        sudo pacman -Sy gcc clang make cmake patch git texinfo flex bison gettext wget gsl gmp mpfr libmpc libusb readline libarchive gpgme bash openssl libtool libusb-compat boost python-pip
    ;;
    *)
        echo "$TESTOS not supported here"
    ;;
    esac

fi
