Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from az33egw02.freescale.net ([192.88.158.103])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OXznL-00047d-Qt
	for kexec@lists.infradead.org; Sun, 11 Jul 2010 16:54:25 +0000
Subject: Re: kexec for powerpc mpc85xx processors
From: Matthew McClintock <msm@freescale.com>
In-Reply-To: <AANLkTilGLXBW3oIvVgnO9ZMVa8qeGBo8HlH1KXJVC5pq@mail.gmail.com>
References: <AANLkTink0yPL5tiAZ88LsALQ0Xf0EeJjPOHCV-YO5ll5@mail.gmail.com>
	<1278656898.25847.2.camel@localhost>
	<20100709064324.GA24576@verge.net.au>
	<AANLkTilsFiyT0hLzHO2cvoZzyu7Bdizsdhr9v_sAGODd@mail.gmail.com>
	<20100710063701.GA12280@verge.net.au>
	<1278746600.20846.1.camel@localhost>
	<AANLkTilGLXBW3oIvVgnO9ZMVa8qeGBo8HlH1KXJVC5pq@mail.gmail.com>
Date: Sun, 11 Jul 2010 11:53:58 -0500
Message-ID: <1278867238.20846.3.camel@localhost>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: krish <radhakrishna.p@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

On Sat, 2010-07-10 at 14:38 +0530, krish wrote:
> Hi,
> 
> I have gone through the kexec syscall implementation in kernel in the
> view of mpc83xx processor. Currently, I am testing for mpc83xx based
> card.

Which are we talking about? You said mpc85xx NOT mpc83xx first, right?

> 
> The compile error i got was:
> kexec/arch/ppc/Makefile:4: kexec/arch/ppc/libfdt/Makefile.libfdt: No
> such file or directory

Well, does this file exist? If not you might not have a complete
kexec-tools package.

> make: *** No rule to make target
> `kexec/arch/ppc/libfdt/Makefile.libfdt'.  Stop.
> 
> I have commented the rule to include Makefile.libfdt in
> "kexec/arch/ppc/Makefile", becuase the rules to compile source files
> of libfdt folder are already present in the arch/ppc/Makefile.
> 
> then i got following compile error:
> /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
> -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
> -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
> kexec/arch/ppc/kexec-ppc.o kexec/arch/ppc/kexec-ppc.c
> kexec/arch/ppc/kexec-ppc.c:24:31: error: crashdump-powerpc.h: No such
> file or directory
> kexec/arch/ppc/kexec-ppc.c: In function 'get_devtree_details':
> kexec/arch/ppc/kexec-ppc.c:389: warning: implicit declaration of
> function 'add_usable_mem_rgns'
> kexec/arch/ppc/kexec-ppc.c:390: error: 'KDUMP_BACKUP_LIMIT' undeclared
> (first use in this function)
> kexec/arch/ppc/kexec-ppc.c:390: error: (Each undeclared identifier is
> reported only once
> kexec/arch/ppc/kexec-ppc.c:390: error: for each function it appears
> in.)
> 
> 
> Below is the full dump of configure and make commands. 
> ==================================================================
> [krishna@Amru kexec-tools-2.0.2-rc1]$ ./configure
> --prefix=/home/krishna/work/KEXEC/kexec-tools-2.0.2-rc1/
> CC=/opt/ELDK41/usr/bin/ppc_6xx-gcc LD=/opt/ELDK41/usr/bin/ppc_6xx-ld
> BUILD_CC=/usr/bin/gcc --target=ppc --host=i686
> TARGET_CC=/opt/ELDK41/usr/bin/ppc_6xx-gcc
> configure: WARNING: If you wanted to set the --build type, don't use
> --host.
>     If a cross compiler is detected then cross compile mode will be
> used.
> checking build system type... i686-pc-linux-gnu
> checking host system type... i686-pc-none
> checking target system type... powerpc-unknown-none
> checking for i686-gcc... /opt/ELDK41/usr/bin/ppc_6xx-gcc
> checking whether the C compiler works... yes
> checking for C compiler default output file name... a.out
> checking for suffix of executables... 
> checking whether we are cross compiling... yes
> checking for suffix of object files... o
> checking whether we are using the GNU C compiler... yes
> checking whether /opt/ELDK41/usr/bin/ppc_6xx-gcc accepts -g... yes
> checking for /opt/ELDK41/usr/bin/ppc_6xx-gcc option to accept ISO
> C89... none needed
> checking for -gcc... /usr/bin/gcc
> checking how to run the C
> preprocessor... /opt/ELDK41/usr/bin/ppc_6xx-gcc -E
> checking for i686-ld... /opt/ELDK41/usr/bin/ppc_6xx-ld
> checking for i686-as... no
> checking for as... as
> configure: WARNING: using cross tools not prefixed with host triplet
> checking for i686-objcopy... no
> checking for objcopy... objcopy
> checking for i686-ar... no
> checking for ar... ar
> checking for ppc-gcc... /opt/ELDK41/usr/bin/ppc_6xx-gcc
> checking for ppc-ld... no
> checking for powerpc-unknown-none-ld... no
> checking for ld... ld
> checking whether /opt/ELDK41/usr/bin/ppc_6xx-gcc accepts
> -fno-zero-initialized-in-bss... Yes
> checking for a BSD-compatible install... /usr/bin/install -c
> checking for mkdir... mkdir
> checking for rm... rm
> checking for cp... cp
> checking for ln... ln
> checking for tar... tar
> checking for rpmbuild... rpmbuild
> checking for sed... sed
> checking for find... find
> checking for xargs... xargs
> checking for dirname... dirname
> checking for grep that handles long lines and -e... /bin/grep
> checking for egrep... /bin/grep -E
> checking for ANSI C header files... yes
> checking for sys/types.h... yes
> checking for sys/stat.h... yes
> checking for stdlib.h... yes
> checking for string.h... yes
> checking for memory.h... yes
> checking for strings.h... yes
> checking for inttypes.h... yes
> checking for stdint.h... yes
> checking for unistd.h... yes
> checking zlib.h usability... yes
> checking zlib.h presence... yes
> checking for zlib.h... yes
> checking for inflateInit_ in -lz... yes
> checking lzma.h usability... no
> checking lzma.h presence... no
> checking for lzma.h... no
> checking xenctrl.h usability... no
> checking xenctrl.h presence... no
> checking for xenctrl.h... no
> configure: creating ./config.status
> config.status: creating Makefile
> config.status: creating include/config.h
> 
> output of "make" command
> --------------------------------------------------------
> /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
> -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
> -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
> kexec/kexec.o kexec/kexec.c
> /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
> -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
> -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
> kexec/ifdown.o kexec/ifdown.c
> /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
> -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
> -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
> kexec/kexec-elf.o kexec/kexec-elf.c
> /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
> -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
> -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
> kexec/kexec-elf-exec.o kexec/kexec-elf-exec.c
> /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
> -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
> -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
> kexec/kexec-elf-core.o kexec/kexec-elf-core.c
> /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
> -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
> -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
> kexec/kexec-elf-rel.o kexec/kexec-elf-rel.c
> /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
> -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
> -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
> kexec/kexec-elf-boot.o kexec/kexec-elf-boot.c
> /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
> -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
> -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
> kexec/kexec-iomem.o kexec/kexec-iomem.c
> /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
> -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
> -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
> kexec/firmware_memmap.o kexec/firmware_memmap.c
> /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
> -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
> -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
> kexec/crashdump.o kexec/crashdump.c
> /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
> -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
> -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
> kexec/crashdump-xen.o kexec/crashdump-xen.c
> /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
> -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
> -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
> kexec/phys_arch.o kexec/phys_arch.c
> /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
> -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
> -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
> kexec/lzma.o kexec/lzma.c
> /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
> -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
> -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
> kexec/zlib.o kexec/zlib.c
> /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
> -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
> -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
> kexec/proc_iomem.o kexec/proc_iomem.c
> /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
> -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
> -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
> kexec/virt_to_phys.o kexec/virt_to_phys.c
> /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
> -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
> -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
> kexec/phys_to_virt.o kexec/phys_to_virt.c
> /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
> -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
> -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
> kexec/add_segment.o kexec/add_segment.c
> /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
> -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
> -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
> kexec/add_buffer.o kexec/add_buffer.c
> /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
> -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
> -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
> kexec/arch_reuse_initrd.o kexec/arch_reuse_initrd.c
> /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
> -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
> -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
> kexec/arch_init.o kexec/arch_init.c
> /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
> -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
> -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
> kexec/arch/ppc/kexec-ppc.o kexec/arch/ppc/kexec-ppc.c
> kexec/arch/ppc/kexec-ppc.c:24:31: error: crashdump-powerpc.h: No such
> file or directory
> kexec/arch/ppc/kexec-ppc.c: In function 'get_devtree_details':
> kexec/arch/ppc/kexec-ppc.c:389: warning: implicit declaration of
> function 'add_usable_mem_rgns'
> kexec/arch/ppc/kexec-ppc.c:390: error: 'KDUMP_BACKUP_LIMIT' undeclared
> (first use in this function)
> kexec/arch/ppc/kexec-ppc.c:390: error: (Each undeclared identifier is
> reported only once
> kexec/arch/ppc/kexec-ppc.c:390: error: for each function it appears
> in.)
> make: *** [kexec/arch/ppc/kexec-ppc.o] Error 1
> ==============================================================
> 
> 
> On Sat, Jul 10, 2010 at 12:53 PM, Matthew McClintock
> <msm@freescale.com> wrote:
>         
>         On Sat, 2010-07-10 at 15:37 +0900, Simon Horman wrote:
>         > On Sat, Jul 10, 2010 at 10:14:25AM +0530, krish wrote:
>         > > Hi,
>         > >
>         > > I am using linux-2.6.34.1 version for both mpc83xx and
>         mpc85xx processors.
>         > > This version of kernel supports kexec for both 83xx and
>         85xx processors.
>         > > I have been using ELDK toolchain for PowerPC processors.
>         > > I am using u-boot as boot loader and uImage & dtb images
>         as Linux images.
>         > >
>         > > I have downloaded 2.0.2-rc1 package and tried to compile
>         for mpc83xx.
>         > > I have used following command to configure kexec-tools for
>         ppc.
>         > > ./configure
>         --prefix=/home/krishna/work/kexec-tools-6dd624d/
>         > > CC=/opt/ELDK41/usr/bin/ppc_6xx-gcc
>         LD=/opt/ELDK41/usr/bin/ppc_6xx-ld
>         > > BUILD_CC=/usr/bin/gcc --target=ppc --host=i686
>         > > CC=/opt/ELDK41/usr/bin/ppc_6xx-gcc
>         > > TARGET_CC=/opt/ELDK41/usr/bin/ppc_6xx-gcc;
>         > >
>         > > The compilation was broken for PPC.
>         >
>         > Could you provide the compile errors that you are seeing?
>         >
>         
>         
>         Also, how do you know your kernel supports kexec?
>         
>         -Matthew
>         
>         
> 
> 
> 
> -- 
> Regards,
> Radha Krishna
> "Yesterday is history, Tomorrow is mystery, Today is gift"

-M



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
