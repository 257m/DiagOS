{ pkgs }: {
	deps = [
 	    pkgs.lld_11
      pkgs.pkgconfig
      	pkgs.vim
      	pkgs.clang_12
		pkgs.ccls
		pkgs.gdb
		pkgs.gnumake
		pkgs.qemu
		pkgs.nasm
		pkgs.binutils-unwrapped
		pkgs.hexdino
		pkgs.gmp
		pkgs.mpfr
		pkgs.libmpc
		pkgs.gcc
		pkgs.binutils-unwrapped
	];
}