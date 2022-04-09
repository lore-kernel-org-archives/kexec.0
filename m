From: Simon Horman <horms@verge.net.au>
Date: Sat, 9 Apr 2022 13:32:30 +0200
Subject: [ANNOUNCE] kexec-tools 2.0.24
Message-ID: <YlFuzrNIJGe4d42/@vergenet.net>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi all,

I am happy to announce the release of kexec-tools 2.0.24.

This is a feature release coinciding with the release of v5.17
of the Linux Kernel.

This release can be downloaded from kernel.org:

	http://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools-2.0.24.tar.xz
	http://kernel.org/pub/linux/utils/kernel/kexec/

It is also tagged it in git:

	git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git

Thanks to everyone who has contributed to kexec!

Commits since v2.0.23:

1d82b3faa331 kexec-tools 2.0.24
272af539f785 kexec-tools 2.0.24-rc1
c1ae085bd211 arm64: fix static data relocations in machine_apply_elf_rel()
2b78a27a64f0 kexec/elf: assign one to align if sh_addralign equals zero
1d8273d82b66 arm64/crashdump-arm64: explicit type conversion to suppress compiler warning
33778949c132 arm64/kexec-arm64: add support for R_AARCH64_MOVW_UABS_G* rela
e2a86b319245 arm64/kexec-arm64: use enum to organize the reloc type
8e3f663a4dfe arm64/kexec-arm64: add support for R_AARCH64_LDST128_ABS_LO12_NC rela
36805fe6ba33 kexec-tools: fix leak FILE pointer.
1b03cf7adc3c purgatory: do not enable vectorization automatically for purgatory compiling
dcfcc73c73e6 kexec-tools: Determine if the image is lzma commpressed
f4c59879b830 util_lib/elf_info: harden parsing of printk buffer
30bfe30bb609 github: run apt-get update before installing packages
501646beec2b kexec-xen: Allow xen_kexec_exec() to return in case of Live Update
1d7a308bf734 kexec-tools: print error if kexec_file_load fails
6effda061f75 kexec-tools: mips: Concatenate --reuse-cmdline and --append
8dda434a05ff kexec-tools: mips: Add some debug info
95de9eccf413 arm64: fix PAGE_OFFSET calc for flipped mm
454395e18ff1 arm64: read VA_BITS from kcore for 52-bits VA kernel
bde864387a10 arm64/crashdump: unify routine to get page_offset
67ea2d99e135 arm64: make phys_offset signed
2e1ec106dc5a s390: add support for --reuse-cmdline
d6516ba4c88f use slurp_proc_file() in get_command_line()
193e51deccc6 add slurp_proc_file()
91a3d0e00a5c s390: use KEXEC_ALL_OPTIONS
defb80a20bf1 s390: add variable command line size
b5a34a20984c arm64: support more than one crash kernel regions
186e7b0752d8 s390: handle R_390_PLT32DBL reloc entries in machine_apply_elf_rel()
1614959f2f0d arm64/crashdump: deduce paddr of _text based on kernel code size
10b7e1fb5d0c kexec-tools 2.0.23.git

