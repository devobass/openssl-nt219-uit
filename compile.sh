#!/usr/bin/env sh

set -e

DEPENDENCIES="git make gcc g++ clang clang++ perl"

CC="gcc"
CXX="g++"
CORE_USE="$(nproc)"
PREFIX="/opt/openssl-nt129/$CC"

if [ "$1" = "--clang" ]
then
	CC="clang"
	CXX="clang++"
fi

printf "Building for %s.\n" "$CC"
printf "Using %s core(s).\n" "$CORE_USE"

if [ $(id -u) != 0 ]
then
	printf "Not running as root.\n"
	exit 1
fi

for dep in $DEPENDENCIES
do
	if ! command -v "$dep" > /dev/null 2>&1
	then
		printf "%s not found in \$PATH.\n" "$dep"
		exit 1
	fi
done

if ! [ -d "$PREFIX" ]
then
	mkdir -p $PREFIX
fi

git clone 'https://github.com/openssl/openssl'
cd openssl

make clean
./Configure CC="$CC" CXX="$CXX" --prefix="$PREFIX"
make -j $CORE_USE
make install -j $CORE_USE

printf "%s/lib64/" "$PREFIX" >> "/etc/ld.so.conf.d/openssl_nt219.conf"
ldconfig

$PREFIX/bin/openssl version && printf "Success.\n"
