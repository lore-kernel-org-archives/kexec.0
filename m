Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mailgw.miraclelinux.com ([122.212.45.247])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1P0R3n-00019D-MX
	for kexec@lists.infradead.org; Tue, 28 Sep 2010 03:40:59 +0000
Message-ID: <4CA163C5.1060704@miraclelinux.com>
Date: Tue, 28 Sep 2010 12:40:53 +0900
From: Makito SHIOKAWA <mshiokawa@miraclelinux.com>
MIME-Version: 1.0
Subject: Re: Can't kexec/kdump on mpc85xx
References: <4C9FFA9E.4080705@miraclelinux.com>
	<81FA9276-7283-4106-9155-83F17327D496@freescale.com>
In-Reply-To: <81FA9276-7283-4106-9155-83F17327D496@freescale.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Matthew McClintock <msm@freescale.com>
Cc: kexec@lists.infradead.org

> First off, what SHA of the kernel are you using? It looks like 2.6.35 should have the patches you need, but I want to double check. Also, how did you compile kexec-tools? Cross compile? What compiler are you using?

As kernel, I used vanilla 2.6.35. 
(http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.35.tar.gz. Git commit 
should be 9fe6206f400646a2322096b56c59891d530e8d51)

As cross compiler, I used "Sourcery G++ Lite 4.4-254 for Power GNU/Linux". 
(http://www.codesourcery.com/sgpp/lite/power/portal/package6842/public/powerpc-linux-gnu/freescale-4.4-254-powerpc-linux-gnu-i686-pc-linux-gnu.tar.bz2).

I cross compiled kernel, kexec-tools on x86 host with it.

* kernel, dtb

# cd linux-2.6.35
# cp arch/powerpc/configs/85xx/mpc85xx_cds_defconfig .config
# make ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- menuconfig
(Set CONFG_KEXEC, CONFIG_RELOCATABLE and others)
# make ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- uImage

# ./scripts/dtc/dtc -f -I dts -O dtb -b powerpc -o mpc8548cds-mod.dtb 
arch/powerpc/boot/dts/mpc8548cds-mod.dts

* kexec-tools (statically compiled)

# cd kexec-tools
# ./bootstrap
# CFLAGS="-static -g -DDEBUG=1" LDFLAGS="-static -g -DDEBUG=1" ./configure 
--host=powerpc-linux-gnu
# make


Rootfs is built with different cross compiler, but I assume it doesn't affect 
much since kexec-tools is statically compiled.

I'll paste kexec-tools build log below.

---
# ./bootstrap
+ aclocal -I config
+ autoheader
+ autoconf
# CFLAGS="-static -g -DDEBUG=1" LDFLAGS="-static -g -DDEBUG=1" ./configure 
--host=powerpc-linux-gnu
configure: WARNING: If you wanted to set the --build type, don't use --host.
     If a cross compiler is detected then cross compile mode will be used.
checking build system type... x86_64-unknown-linux-gnu
checking host system type... powerpc-unknown-linux-gnu
checking target system type... powerpc-unknown-linux-gnu
checking for powerpc-linux-gnu-gcc... powerpc-linux-gnu-gcc
checking for C compiler default output file name... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... yes
checking for suffix of executables...
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether powerpc-linux-gnu-gcc accepts -g... yes
checking for powerpc-linux-gnu-gcc option to accept ANSI C... none needed
checking for -gcc... no
checking for x86_64-unknown-linux-gnu-gcc... no
checking for gcc... gcc
checking how to run the C preprocessor... powerpc-linux-gnu-gcc -E
checking for powerpc-linux-gnu-ld... powerpc-linux-gnu-ld
checking for powerpc-linux-gnu-as... powerpc-linux-gnu-as
checking for powerpc-linux-gnu-objcopy... powerpc-linux-gnu-objcopy
checking for powerpc-linux-gnu-ar... powerpc-linux-gnu-ar
checking whether powerpc-linux-gnu-gcc accepts -fno-zero-initialized-in-bss... Yes
checking for a BSD-compatible install... /usr/bin/install -c
checking for mkdir... mkdir
checking for rm... rm
checking for cp... cp
checking for ln... ln
checking for tar... tar
checking for rpmbuild... rpmbuild
checking for sed... sed
checking for find... find
checking for xargs... xargs
checking for dirname... dirname
checking for egrep... grep -E
checking for ANSI C header files... yes
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for memory.h... yes
checking for strings.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for unistd.h... yes
checking zlib.h usability... no
checking zlib.h presence... no
checking for zlib.h... no
checking lzma.h usability... no
checking lzma.h presence... no
checking for lzma.h... no
checking xenctrl.h usability... no
checking xenctrl.h presence... no
checking for xenctrl.h... no
configure: creating ./config.status
config.status: creating Makefile
config.status: creating include/config.h
config.status: include/config.h is unchanged
# make
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/ 
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o kexec/kexec.o 
kexec/kexec.c
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/ 
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o kexec/ifdown.o 
kexec/ifdown.c
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/ 
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o 
kexec/kexec-elf.o kexec/kexec-elf.c
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/ 
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o 
kexec/kexec-elf-exec.o kexec/kexec-elf-exec.c
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/ 
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o 
kexec/kexec-elf-core.o kexec/kexec-elf-core.c
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/ 
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o 
kexec/kexec-elf-rel.o kexec/kexec-elf-rel.c
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/ 
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o 
kexec/kexec-elf-boot.o kexec/kexec-elf-boot.c
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/ 
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o 
kexec/kexec-iomem.o kexec/kexec-iomem.c
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/ 
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o 
kexec/firmware_memmap.o kexec/firmware_memmap.c
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/ 
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o 
kexec/crashdump.o kexec/crashdump.c
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/ 
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o 
kexec/crashdump-xen.o kexec/crashdump-xen.c
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/ 
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o 
kexec/phys_arch.o kexec/phys_arch.c
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/ 
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o kexec/lzma.o 
kexec/lzma.c
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/ 
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o kexec/zlib.o 
kexec/zlib.c
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/ 
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o 
kexec/proc_iomem.o kexec/proc_iomem.c
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/ 
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o 
kexec/virt_to_phys.o kexec/virt_to_phys.c
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/ 
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o 
kexec/phys_to_virt.o kexec/phys_to_virt.c
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/ 
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o 
kexec/add_segment.o kexec/add_segment.c
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/ 
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o 
kexec/add_buffer.o kexec/add_buffer.c
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/ 
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o 
kexec/arch_init.o kexec/arch_init.c
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/ 
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o 
kexec/arch/ppc/kexec-ppc.o kexec/arch/ppc/kexec-ppc.c
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/ 
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o 
kexec/arch/ppc/kexec-elf-ppc.o kexec/arch/ppc/kexec-elf-ppc.c
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/ 
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o 
kexec/arch/ppc/kexec-elf-rel-ppc.o kexec/arch/ppc/kexec-elf-rel-ppc.c
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/ 
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o 
kexec/arch/ppc/kexec-dol-ppc.o kexec/arch/ppc/kexec-dol-ppc.c
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/ 
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o 
kexec/arch/ppc/kexec-uImage-ppc.o kexec/arch/ppc/kexec-uImage-ppc.c
powerpc-linux-gnu-gcc  -I./include -I./util_lib/include -Iinclude/ 
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o 
kexec/arch/ppc/ppc-setup-simple.o kexec/arch/ppc/ppc-setup-simple.S
powerpc-linux-gnu-gcc  -I./include -I./util_lib/include -Iinclude/ 
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o 
kexec/arch/ppc/ppc-setup-dol.o kexec/arch/ppc/ppc-setup-dol.S
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/ 
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o 
kexec/arch/ppc/fixup_dtb.o kexec/arch/ppc/fixup_dtb.c
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/ 
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o 
kexec/arch/ppc/fs2dt.o kexec/arch/ppc/fs2dt.c
kexec/arch/ppc/fs2dt.c: In function 'putnode':
kexec/arch/ppc/fs2dt.c:336: warning: passing argument 4 of 'scandir' from 
incompatible pointer type
/opt/freescale-4.4/bin/../powerpc-linux-gnu/libc/usr/include/dirent.h:252: 
note: expected 'int (*)(const struct dirent **, const struct dirent **)' but 
argument is of type 'int (*)(const void *, const void *)'
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/ 
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o 
kexec/arch/ppc/crashdump-powerpc.o kexec/arch/ppc/crashdump-powerpc.c
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/ 
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o 
kexec/kexec-uImage.o kexec/kexec-uImage.c
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/ 
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o 
kexec/arch/ppc/libfdt-wrapper.o kexec/arch/ppc/libfdt-wrapper.c
kexec/arch/ppc/libfdt-wrapper.c:31: warning: "DEBUG" redefined
<command-line>:0: note: this is the location of the previous definition
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/ 
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o 
kexec/arch/ppc/libfdt/fdt.o kexec/arch/ppc/libfdt/fdt.c
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/ 
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o 
kexec/arch/ppc/libfdt/fdt_ro.o kexec/arch/ppc/libfdt/fdt_ro.c
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/ 
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o 
kexec/arch/ppc/libfdt/fdt_wip.o kexec/arch/ppc/libfdt/fdt_wip.c
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/ 
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o 
kexec/arch/ppc/libfdt/fdt_sw.o kexec/arch/ppc/libfdt/fdt_sw.c
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/ 
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o 
kexec/arch/ppc/libfdt/fdt_rw.o kexec/arch/ppc/libfdt/fdt_rw.c
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/ 
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o 
kexec/arch/ppc/libfdt/fdt_strerror.o kexec/arch/ppc/libfdt/fdt_strerror.c
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -fno-zero-initialized-in-bss  -Os -fno-builtin 
-ffreestanding  -I./purgatory/include -I./purgatory/arch/ppc/include 
-I./util_lib/include -I./include 
-I/opt/freescale-4.4/bin/../lib/gcc/powerpc-linux-gnu/4.4.1/include  -c -MD -o 
purgatory/purgatory.o purgatory/purgatory.c
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -fno-zero-initialized-in-bss  -Os -fno-builtin 
-ffreestanding  -I./purgatory/include -I./purgatory/arch/ppc/include 
-I./util_lib/include -I./include 
-I/opt/freescale-4.4/bin/../lib/gcc/powerpc-linux-gnu/4.4.1/include  -c -MD -o 
purgatory/printf.o purgatory/printf.c
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -fno-zero-initialized-in-bss  -Os -fno-builtin 
-ffreestanding  -I./purgatory/include -I./purgatory/arch/ppc/include 
-I./util_lib/include -I./include 
-I/opt/freescale-4.4/bin/../lib/gcc/powerpc-linux-gnu/4.4.1/include  -c -MD -o 
purgatory/string.o purgatory/string.c
powerpc-linux-gnu-gcc   -I./purgatory/include -I./purgatory/arch/ppc/include 
-I./util_lib/include -I./include 
-I/opt/freescale-4.4/bin/../lib/gcc/powerpc-linux-gnu/4.4.1/include  -c -MD -o 
purgatory/arch/ppc/v2wrap_32.o purgatory/arch/ppc/v2wrap_32.S
powerpc-linux-gnu-gcc   -I./purgatory/include -I./purgatory/arch/ppc/include 
-I./util_lib/include -I./include 
-I/opt/freescale-4.4/bin/../lib/gcc/powerpc-linux-gnu/4.4.1/include  -c -MD -o 
purgatory/arch/ppc/misc.o purgatory/arch/ppc/misc.S
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -fno-zero-initialized-in-bss  -Os -fno-builtin 
-ffreestanding  -I./purgatory/include -I./purgatory/arch/ppc/include 
-I./util_lib/include -I./include 
-I/opt/freescale-4.4/bin/../lib/gcc/powerpc-linux-gnu/4.4.1/include  -c -MD -o 
purgatory/arch/ppc/purgatory-ppc.o purgatory/arch/ppc/purgatory-ppc.c
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -fno-zero-initialized-in-bss  -Os -fno-builtin 
-ffreestanding  -I./purgatory/include -I./purgatory/arch/ppc/include 
-I./util_lib/include -I./include 
-I/opt/freescale-4.4/bin/../lib/gcc/powerpc-linux-gnu/4.4.1/include  -c -MD -o 
purgatory/arch/ppc/console-ppc.o purgatory/arch/ppc/console-ppc.c
mkdir -p purgatory
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -fno-zero-initialized-in-bss  -Os -fno-builtin 
-ffreestanding -O0  -I./purgatory/include -I./purgatory/arch/ppc/include 
-I./util_lib/include -I./include 
-I/opt/freescale-4.4/bin/../lib/gcc/powerpc-linux-gnu/4.4.1/include  -c -o 
purgatory/sha256.o util_lib/sha256.c
mkdir -p purgatory
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -fno-zero-initialized-in-bss  -Os -fno-builtin 
-ffreestanding  --no-undefined -nostartfiles -nostdlib -nodefaultlibs -e 
purgatory_start -r -o purgatory/purgatory.ro purgatory/purgatory.o 
purgatory/printf.o purgatory/string.o purgatory/arch/ppc/v2wrap_32.o 
purgatory/arch/ppc/misc.o purgatory/arch/ppc/purgatory-ppc.o 
purgatory/arch/ppc/console-ppc.o purgatory/sha256.o
gcc   -O2 -Wall -o bin/bin-to-hex util/bin-to-hex.c
mkdir -p kexec
bin/bin-to-hex purgatory < purgatory/purgatory.ro > kexec/purgatory.c
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/ 
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o 
kexec/purgatory.o kexec/purgatory.c
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/ 
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include -I./util_lib/include  -c 
-MD -o util_lib/compute_ip_checksum.o util_lib/compute_ip_checksum.c
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/ 
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include -I./util_lib/include  -c 
-MD -o util_lib/sha256.o util_lib/sha256.c
powerpc-linux-gnu-ar rs libutil.a util_lib/compute_ip_checksum.o util_lib/sha256.o
powerpc-linux-gnu-ar: creating libutil.a
powerpc-linux-gnu-gcc -static -g -DDEBUG=1  -o build/sbin/kexec kexec/kexec.o 
kexec/ifdown.o kexec/kexec-elf.o kexec/kexec-elf-exec.o kexec/kexec-elf-core.o 
kexec/kexec-elf-rel.o kexec/kexec-elf-boot.o kexec/kexec-iomem.o 
kexec/firmware_memmap.o kexec/crashdump.o kexec/crashdump-xen.o 
kexec/phys_arch.o kexec/lzma.o kexec/zlib.o kexec/proc_iomem.o 
kexec/virt_to_phys.o kexec/phys_to_virt.o kexec/add_segment.o 
kexec/add_buffer.o kexec/arch_init.o kexec/arch/ppc/kexec-ppc.o 
kexec/arch/ppc/kexec-elf-ppc.o kexec/arch/ppc/kexec-elf-rel-ppc.o 
kexec/arch/ppc/kexec-dol-ppc.o kexec/arch/ppc/kexec-uImage-ppc.o 
kexec/arch/ppc/ppc-setup-simple.o kexec/arch/ppc/ppc-setup-dol.o 
kexec/arch/ppc/fixup_dtb.o kexec/arch/ppc/fs2dt.o 
kexec/arch/ppc/crashdump-powerpc.o kexec/kexec-uImage.o 
kexec/arch/ppc/libfdt-wrapper.o kexec/arch/ppc/libfdt/fdt.o 
kexec/arch/ppc/libfdt/fdt_ro.o kexec/arch/ppc/libfdt/fdt_wip.o 
kexec/arch/ppc/libfdt/fdt_sw.o kexec/arch/ppc/libfdt/fdt_rw.o 
kexec/arch/ppc/libfdt/fdt_strerror.o kexec/purgatory.o libutil.a -static -g 
-DDEBUG=1 -fno-strict-aliasing -Wall -Wstrict-prototypes
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/ 
-I./kexec/arch/ppc/libfdt  -c -MD -o kdump/kdump.o kdump/kdump.c
powerpc-linux-gnu-gcc -static -g -DDEBUG=1 -fno-strict-aliasing -Wall 
-Wstrict-prototypes  -o build/sbin/kdump kdump/kdump.o
cp kexec/kexec.8 build/man/man8/kexec.8
mkdir -p     build/man/man8
cp kdump/kdump.8 build/man/man8/kdump.8
---

Thanks,

--
Makito SHIOKAWA <mshiokawa@miraclelinux.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
