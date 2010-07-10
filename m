Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-gw0-f49.google.com ([74.125.83.49])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OXW2i-0004Dw-Nj
	for kexec@lists.infradead.org; Sat, 10 Jul 2010 09:08:19 +0000
Received: by gwj21 with SMTP id 21so1524843gwj.36
	for <kexec@lists.infradead.org>; Sat, 10 Jul 2010 02:08:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1278746600.20846.1.camel@localhost>
References: <AANLkTink0yPL5tiAZ88LsALQ0Xf0EeJjPOHCV-YO5ll5@mail.gmail.com>
	<1278656898.25847.2.camel@localhost>
	<20100709064324.GA24576@verge.net.au>
	<AANLkTilsFiyT0hLzHO2cvoZzyu7Bdizsdhr9v_sAGODd@mail.gmail.com>
	<20100710063701.GA12280@verge.net.au>
	<1278746600.20846.1.camel@localhost>
Date: Sat, 10 Jul 2010 14:38:14 +0530
Message-ID: <AANLkTilGLXBW3oIvVgnO9ZMVa8qeGBo8HlH1KXJVC5pq@mail.gmail.com>
Subject: Re: kexec for powerpc mpc85xx processors
From: krish <radhakrishna.p@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0498066463=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Matthew McClintock <msm@freescale.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

--===============0498066463==
Content-Type: multipart/alternative; boundary=0016362843e80f35a2048b04dc8d

--0016362843e80f35a2048b04dc8d
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I have gone through the kexec syscall implementation in kernel in the view
of mpc83xx processor. Currently, I am testing for mpc83xx based card.

The compile error i got was:
kexec/arch/ppc/Makefile:4: kexec/arch/ppc/libfdt/Makefile.libfdt: No such
file or directory
make: *** No rule to make target `kexec/arch/ppc/libfdt/Makefile.libfdt'.
Stop.

I have commented the rule to include Makefile.libfdt in
"kexec/arch/ppc/Makefile", becuase the rules to compile source files of
libfdt folder are already present in the arch/ppc/Makefile.

then i got following compile error:
/opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
kexec/arch/ppc/kexec-ppc.o kexec/arch/ppc/kexec-ppc.c
kexec/arch/ppc/kexec-ppc.c:24:31: error: crashdump-powerpc.h: No such file
or directory
kexec/arch/ppc/kexec-ppc.c: In function 'get_devtree_details':
kexec/arch/ppc/kexec-ppc.c:389: warning: implicit declaration of function
'add_usable_mem_rgns'
kexec/arch/ppc/kexec-ppc.c:390: error: 'KDUMP_BACKUP_LIMIT' undeclared
(first use in this function)
kexec/arch/ppc/kexec-ppc.c:390: error: (Each undeclared identifier is
reported only once
kexec/arch/ppc/kexec-ppc.c:390: error: for each function it appears in.)


Below is the full dump of configure and make commands.
==================================================================
[krishna@Amru kexec-tools-2.0.2-rc1]$ ./configure
--prefix=/home/krishna/work/KEXEC/kexec-tools-2.0.2-rc1/
CC=/opt/ELDK41/usr/bin/ppc_6xx-gcc LD=/opt/ELDK41/usr/bin/ppc_6xx-ld
BUILD_CC=/usr/bin/gcc --target=ppc --host=i686
TARGET_CC=/opt/ELDK41/usr/bin/ppc_6xx-gcc
configure: WARNING: If you wanted to set the --build type, don't use --host.
    If a cross compiler is detected then cross compile mode will be used.
checking build system type... i686-pc-linux-gnu
checking host system type... i686-pc-none
checking target system type... powerpc-unknown-none
checking for i686-gcc... /opt/ELDK41/usr/bin/ppc_6xx-gcc
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables...
checking whether we are cross compiling... yes
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether /opt/ELDK41/usr/bin/ppc_6xx-gcc accepts -g... yes
checking for /opt/ELDK41/usr/bin/ppc_6xx-gcc option to accept ISO C89...
none needed
checking for -gcc... /usr/bin/gcc
checking how to run the C preprocessor... /opt/ELDK41/usr/bin/ppc_6xx-gcc -E
checking for i686-ld... /opt/ELDK41/usr/bin/ppc_6xx-ld
checking for i686-as... no
checking for as... as
configure: WARNING: using cross tools not prefixed with host triplet
checking for i686-objcopy... no
checking for objcopy... objcopy
checking for i686-ar... no
checking for ar... ar
checking for ppc-gcc... /opt/ELDK41/usr/bin/ppc_6xx-gcc
checking for ppc-ld... no
checking for powerpc-unknown-none-ld... no
checking for ld... ld
checking whether /opt/ELDK41/usr/bin/ppc_6xx-gcc accepts
-fno-zero-initialized-in-bss... Yes
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
checking for grep that handles long lines and -e... /bin/grep
checking for egrep... /bin/grep -E
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
checking zlib.h usability... yes
checking zlib.h presence... yes
checking for zlib.h... yes
checking for inflateInit_ in -lz... yes
checking lzma.h usability... no
checking lzma.h presence... no
checking for lzma.h... no
checking xenctrl.h usability... no
checking xenctrl.h presence... no
checking for xenctrl.h... no
configure: creating ./config.status
config.status: creating Makefile
config.status: creating include/config.h

output of "make" command
--------------------------------------------------------
/opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
kexec/kexec.o kexec/kexec.c
/opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
kexec/ifdown.o kexec/ifdown.c
/opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
kexec/kexec-elf.o kexec/kexec-elf.c
/opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
kexec/kexec-elf-exec.o kexec/kexec-elf-exec.c
/opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
kexec/kexec-elf-core.o kexec/kexec-elf-core.c
/opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
kexec/kexec-elf-rel.o kexec/kexec-elf-rel.c
/opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
kexec/kexec-elf-boot.o kexec/kexec-elf-boot.c
/opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
kexec/kexec-iomem.o kexec/kexec-iomem.c
/opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
kexec/firmware_memmap.o kexec/firmware_memmap.c
/opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
kexec/crashdump.o kexec/crashdump.c
/opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
kexec/crashdump-xen.o kexec/crashdump-xen.c
/opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
kexec/phys_arch.o kexec/phys_arch.c
/opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o kexec/lzma.o
kexec/lzma.c
/opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o kexec/zlib.o
kexec/zlib.c
/opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
kexec/proc_iomem.o kexec/proc_iomem.c
/opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
kexec/virt_to_phys.o kexec/virt_to_phys.c
/opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
kexec/phys_to_virt.o kexec/phys_to_virt.c
/opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
kexec/add_segment.o kexec/add_segment.c
/opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
kexec/add_buffer.o kexec/add_buffer.c
/opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
kexec/arch_reuse_initrd.o kexec/arch_reuse_initrd.c
/opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
kexec/arch_init.o kexec/arch_init.c
/opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
-Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
-I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
kexec/arch/ppc/kexec-ppc.o kexec/arch/ppc/kexec-ppc.c
kexec/arch/ppc/kexec-ppc.c:24:31: error: crashdump-powerpc.h: No such file
or directory
kexec/arch/ppc/kexec-ppc.c: In function 'get_devtree_details':
kexec/arch/ppc/kexec-ppc.c:389: warning: implicit declaration of function
'add_usable_mem_rgns'
kexec/arch/ppc/kexec-ppc.c:390: error: 'KDUMP_BACKUP_LIMIT' undeclared
(first use in this function)
kexec/arch/ppc/kexec-ppc.c:390: error: (Each undeclared identifier is
reported only once
kexec/arch/ppc/kexec-ppc.c:390: error: for each function it appears in.)
make: *** [kexec/arch/ppc/kexec-ppc.o] Error 1
==============================================================


On Sat, Jul 10, 2010 at 12:53 PM, Matthew McClintock <msm@freescale.com>wrote:

> On Sat, 2010-07-10 at 15:37 +0900, Simon Horman wrote:
> > On Sat, Jul 10, 2010 at 10:14:25AM +0530, krish wrote:
> > > Hi,
> > >
> > > I am using linux-2.6.34.1 version for both mpc83xx and mpc85xx
> processors.
> > > This version of kernel supports kexec for both 83xx and 85xx
> processors.
> > > I have been using ELDK toolchain for PowerPC processors.
> > > I am using u-boot as boot loader and uImage & dtb images as Linux
> images.
> > >
> > > I have downloaded 2.0.2-rc1 package and tried to compile for mpc83xx.
> > > I have used following command to configure kexec-tools for ppc.
> > > ./configure --prefix=/home/krishna/work/kexec-tools-6dd624d/
> > > CC=/opt/ELDK41/usr/bin/ppc_6xx-gcc LD=/opt/ELDK41/usr/bin/ppc_6xx-ld
> > > BUILD_CC=/usr/bin/gcc --target=ppc --host=i686
> > > CC=/opt/ELDK41/usr/bin/ppc_6xx-gcc
> > > TARGET_CC=/opt/ELDK41/usr/bin/ppc_6xx-gcc;
> > >
> > > The compilation was broken for PPC.
> >
> > Could you provide the compile errors that you are seeing?
> >
>
> Also, how do you know your kernel supports kexec?
>
> -Matthew
>
>
>


-- 
Regards,
Radha Krishna
"Yesterday is history, Tomorrow is mystery, Today is gift"

--0016362843e80f35a2048b04dc8d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I have gone through the kexec syscall implementation in kernel i=
n the view of mpc83xx processor. Currently, I am testing for mpc83xx based =
card.<br><br>The compile error i got was:<br>kexec/arch/ppc/Makefile:4: kex=
ec/arch/ppc/libfdt/Makefile.libfdt: No such file or directory<br>
make: *** No rule to make target `kexec/arch/ppc/libfdt/Makefile.libfdt&#39=
;.=A0 Stop.<br><br>I have commented the rule to include Makefile.libfdt in =
&quot;kexec/arch/ppc/Makefile&quot;, becuase the rules to compile source fi=
les of libfdt folder are already present in the arch/ppc/Makefile.<br>
<br>then i got following compile error:<br>/opt/ELDK41/usr/bin/ppc_6xx-gcc =
-g -O2 -fno-strict-aliasing -Wall -Wstrict-prototypes -I./include -I./util_=
lib/include -Iinclude/ -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include=
=A0 -c -MD -o kexec/arch/ppc/kexec-ppc.o kexec/arch/ppc/kexec-ppc.c<br>
kexec/arch/ppc/kexec-ppc.c:24:31: error: crashdump-powerpc.h: No such file =
or directory<br>kexec/arch/ppc/kexec-ppc.c: In function &#39;get_devtree_de=
tails&#39;:<br>kexec/arch/ppc/kexec-ppc.c:389: warning: implicit declaratio=
n of function &#39;add_usable_mem_rgns&#39;<br>
kexec/arch/ppc/kexec-ppc.c:390: error: &#39;KDUMP_BACKUP_LIMIT&#39; undecla=
red (first use in this function)<br>kexec/arch/ppc/kexec-ppc.c:390: error: =
(Each undeclared identifier is reported only once<br>kexec/arch/ppc/kexec-p=
pc.c:390: error: for each function it appears in.)<br>
<br><br>Below is the full dump of configure and make commands. <br>=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>[krishna@Amru kexec-tools-2.0=
.2-rc1]$ ./configure --prefix=3D/home/krishna/work/KEXEC/kexec-tools-2.0.2-=
rc1/ CC=3D/opt/ELDK41/usr/bin/ppc_6xx-gcc LD=3D/opt/ELDK41/usr/bin/ppc_6xx-=
ld BUILD_CC=3D/usr/bin/gcc --target=3Dppc --host=3Di686 TARGET_CC=3D/opt/EL=
DK41/usr/bin/ppc_6xx-gcc<br>
configure: WARNING: If you wanted to set the --build type, don&#39;t use --=
host.<br>=A0=A0=A0 If a cross compiler is detected then cross compile mode =
will be used.<br>checking build system type... i686-pc-linux-gnu<br>checkin=
g host system type... i686-pc-none<br>
checking target system type... powerpc-unknown-none<br>checking for i686-gc=
c... /opt/ELDK41/usr/bin/ppc_6xx-gcc<br>checking whether the C compiler wor=
ks... yes<br>checking for C compiler default output file name... a.out<br>
checking for suffix of executables... <br>checking whether we are cross com=
piling... yes<br>checking for suffix of object files... o<br>checking wheth=
er we are using the GNU C compiler... yes<br>checking whether /opt/ELDK41/u=
sr/bin/ppc_6xx-gcc accepts -g... yes<br>
checking for /opt/ELDK41/usr/bin/ppc_6xx-gcc option to accept ISO C89... no=
ne needed<br>checking for -gcc... /usr/bin/gcc<br>checking how to run the C=
 preprocessor... /opt/ELDK41/usr/bin/ppc_6xx-gcc -E<br>checking for i686-ld=
... /opt/ELDK41/usr/bin/ppc_6xx-ld<br>
checking for i686-as... no<br>checking for as... as<br>configure: WARNING: =
using cross tools not prefixed with host triplet<br>checking for i686-objco=
py... no<br>checking for objcopy... objcopy<br>checking for i686-ar... no<b=
r>
checking for ar... ar<br>checking for ppc-gcc... /opt/ELDK41/usr/bin/ppc_6x=
x-gcc<br>checking for ppc-ld... no<br>checking for powerpc-unknown-none-ld.=
.. no<br>checking for ld... ld<br>checking whether /opt/ELDK41/usr/bin/ppc_=
6xx-gcc accepts -fno-zero-initialized-in-bss... Yes<br>
checking for a BSD-compatible install... /usr/bin/install -c<br>checking fo=
r mkdir... mkdir<br>checking for rm... rm<br>checking for cp... cp<br>check=
ing for ln... ln<br>checking for tar... tar<br>checking for rpmbuild... rpm=
build<br>
checking for sed... sed<br>checking for find... find<br>checking for xargs.=
.. xargs<br>checking for dirname... dirname<br>checking for grep that handl=
es long lines and -e... /bin/grep<br>checking for egrep... /bin/grep -E<br>
checking for ANSI C header files... yes<br>checking for sys/types.h... yes<=
br>checking for sys/stat.h... yes<br>checking for stdlib.h... yes<br>checki=
ng for string.h... yes<br>checking for memory.h... yes<br>checking for stri=
ngs.h... yes<br>
checking for inttypes.h... yes<br>checking for stdint.h... yes<br>checking =
for unistd.h... yes<br>checking zlib.h usability... yes<br>checking zlib.h =
presence... yes<br>checking for zlib.h... yes<br>checking for inflateInit_ =
in -lz... yes<br>
checking lzma.h usability... no<br>checking lzma.h presence... no<br>checki=
ng for lzma.h... no<br>checking xenctrl.h usability... no<br>checking xenct=
rl.h presence... no<br>checking for xenctrl.h... no<br>configure: creating =
./config.status<br>
config.status: creating Makefile<br>config.status: creating include/config.=
h<br><br>output of &quot;make&quot; command<br>----------------------------=
----------------------------<br>/opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno=
-strict-aliasing -Wall -Wstrict-prototypes -I./include -I./util_lib/include=
 -Iinclude/ -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include=A0 -c -MD =
-o kexec/kexec.o kexec/kexec.c<br>
/opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall -Wstrict-=
prototypes -I./include -I./util_lib/include -Iinclude/ -I./kexec/arch/ppc/l=
ibfdt -I./kexec/arch/ppc/include=A0 -c -MD -o kexec/ifdown.o kexec/ifdown.c=
<br>
/opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall -Wstrict-=
prototypes -I./include -I./util_lib/include -Iinclude/ -I./kexec/arch/ppc/l=
ibfdt -I./kexec/arch/ppc/include=A0 -c -MD -o kexec/kexec-elf.o kexec/kexec=
-elf.c<br>
/opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall -Wstrict-=
prototypes -I./include -I./util_lib/include -Iinclude/ -I./kexec/arch/ppc/l=
ibfdt -I./kexec/arch/ppc/include=A0 -c -MD -o kexec/kexec-elf-exec.o kexec/=
kexec-elf-exec.c<br>
/opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall -Wstrict-=
prototypes -I./include -I./util_lib/include -Iinclude/ -I./kexec/arch/ppc/l=
ibfdt -I./kexec/arch/ppc/include=A0 -c -MD -o kexec/kexec-elf-core.o kexec/=
kexec-elf-core.c<br>
/opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall -Wstrict-=
prototypes -I./include -I./util_lib/include -Iinclude/ -I./kexec/arch/ppc/l=
ibfdt -I./kexec/arch/ppc/include=A0 -c -MD -o kexec/kexec-elf-rel.o kexec/k=
exec-elf-rel.c<br>
/opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall -Wstrict-=
prototypes -I./include -I./util_lib/include -Iinclude/ -I./kexec/arch/ppc/l=
ibfdt -I./kexec/arch/ppc/include=A0 -c -MD -o kexec/kexec-elf-boot.o kexec/=
kexec-elf-boot.c<br>
/opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall -Wstrict-=
prototypes -I./include -I./util_lib/include -Iinclude/ -I./kexec/arch/ppc/l=
ibfdt -I./kexec/arch/ppc/include=A0 -c -MD -o kexec/kexec-iomem.o kexec/kex=
ec-iomem.c<br>
/opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall -Wstrict-=
prototypes -I./include -I./util_lib/include -Iinclude/ -I./kexec/arch/ppc/l=
ibfdt -I./kexec/arch/ppc/include=A0 -c -MD -o kexec/firmware_memmap.o kexec=
/firmware_memmap.c<br>
/opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall -Wstrict-=
prototypes -I./include -I./util_lib/include -Iinclude/ -I./kexec/arch/ppc/l=
ibfdt -I./kexec/arch/ppc/include=A0 -c -MD -o kexec/crashdump.o kexec/crash=
dump.c<br>
/opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall -Wstrict-=
prototypes -I./include -I./util_lib/include -Iinclude/ -I./kexec/arch/ppc/l=
ibfdt -I./kexec/arch/ppc/include=A0 -c -MD -o kexec/crashdump-xen.o kexec/c=
rashdump-xen.c<br>
/opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall -Wstrict-=
prototypes -I./include -I./util_lib/include -Iinclude/ -I./kexec/arch/ppc/l=
ibfdt -I./kexec/arch/ppc/include=A0 -c -MD -o kexec/phys_arch.o kexec/phys_=
arch.c<br>
/opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall -Wstrict-=
prototypes -I./include -I./util_lib/include -Iinclude/ -I./kexec/arch/ppc/l=
ibfdt -I./kexec/arch/ppc/include=A0 -c -MD -o kexec/lzma.o kexec/lzma.c<br>
/opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall -Wstrict-=
prototypes -I./include -I./util_lib/include -Iinclude/ -I./kexec/arch/ppc/l=
ibfdt -I./kexec/arch/ppc/include=A0 -c -MD -o kexec/zlib.o kexec/zlib.c<br>
/opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall -Wstrict-=
prototypes -I./include -I./util_lib/include -Iinclude/ -I./kexec/arch/ppc/l=
ibfdt -I./kexec/arch/ppc/include=A0 -c -MD -o kexec/proc_iomem.o kexec/proc=
_iomem.c<br>
/opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall -Wstrict-=
prototypes -I./include -I./util_lib/include -Iinclude/ -I./kexec/arch/ppc/l=
ibfdt -I./kexec/arch/ppc/include=A0 -c -MD -o kexec/virt_to_phys.o kexec/vi=
rt_to_phys.c<br>
/opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall -Wstrict-=
prototypes -I./include -I./util_lib/include -Iinclude/ -I./kexec/arch/ppc/l=
ibfdt -I./kexec/arch/ppc/include=A0 -c -MD -o kexec/phys_to_virt.o kexec/ph=
ys_to_virt.c<br>
/opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall -Wstrict-=
prototypes -I./include -I./util_lib/include -Iinclude/ -I./kexec/arch/ppc/l=
ibfdt -I./kexec/arch/ppc/include=A0 -c -MD -o kexec/add_segment.o kexec/add=
_segment.c<br>
/opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall -Wstrict-=
prototypes -I./include -I./util_lib/include -Iinclude/ -I./kexec/arch/ppc/l=
ibfdt -I./kexec/arch/ppc/include=A0 -c -MD -o kexec/add_buffer.o kexec/add_=
buffer.c<br>
/opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall -Wstrict-=
prototypes -I./include -I./util_lib/include -Iinclude/ -I./kexec/arch/ppc/l=
ibfdt -I./kexec/arch/ppc/include=A0 -c -MD -o kexec/arch_reuse_initrd.o kex=
ec/arch_reuse_initrd.c<br>
/opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall -Wstrict-=
prototypes -I./include -I./util_lib/include -Iinclude/ -I./kexec/arch/ppc/l=
ibfdt -I./kexec/arch/ppc/include=A0 -c -MD -o kexec/arch_init.o kexec/arch_=
init.c<br>
/opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall -Wstrict-=
prototypes -I./include -I./util_lib/include -Iinclude/ -I./kexec/arch/ppc/l=
ibfdt -I./kexec/arch/ppc/include=A0 -c -MD -o kexec/arch/ppc/kexec-ppc.o ke=
xec/arch/ppc/kexec-ppc.c<br>
kexec/arch/ppc/kexec-ppc.c:24:31: error: crashdump-powerpc.h: No such file =
or directory<br>kexec/arch/ppc/kexec-ppc.c: In function &#39;get_devtree_de=
tails&#39;:<br>kexec/arch/ppc/kexec-ppc.c:389: warning: implicit declaratio=
n of function &#39;add_usable_mem_rgns&#39;<br>
kexec/arch/ppc/kexec-ppc.c:390: error: &#39;KDUMP_BACKUP_LIMIT&#39; undecla=
red (first use in this function)<br>kexec/arch/ppc/kexec-ppc.c:390: error: =
(Each undeclared identifier is reported only once<br>kexec/arch/ppc/kexec-p=
pc.c:390: error: for each function it appears in.)<br>
make: *** [kexec/arch/ppc/kexec-ppc.o] Error 1<br>=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D<br><br><br><div class=3D"gmail_quote">On Sat, Jul 10, 2010 at =
12:53 PM, Matthew McClintock <span dir=3D"ltr">&lt;<a href=3D"mailto:msm@fr=
eescale.com">msm@freescale.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div></div><=
div class=3D"h5">On Sat, 2010-07-10 at 15:37 +0900, Simon Horman wrote:<br>
&gt; On Sat, Jul 10, 2010 at 10:14:25AM +0530, krish wrote:<br>
&gt; &gt; Hi,<br>
&gt; &gt;<br>
&gt; &gt; I am using linux-2.6.34.1 version for both mpc83xx and mpc85xx pr=
ocessors.<br>
&gt; &gt; This version of kernel supports kexec for both 83xx and 85xx proc=
essors.<br>
&gt; &gt; I have been using ELDK toolchain for PowerPC processors.<br>
&gt; &gt; I am using u-boot as boot loader and uImage &amp; dtb images as L=
inux images.<br>
&gt; &gt;<br>
&gt; &gt; I have downloaded 2.0.2-rc1 package and tried to compile for mpc8=
3xx.<br>
&gt; &gt; I have used following command to configure kexec-tools for ppc.<b=
r>
&gt; &gt; ./configure --prefix=3D/home/krishna/work/kexec-tools-6dd624d/<br=
>
&gt; &gt; CC=3D/opt/ELDK41/usr/bin/ppc_6xx-gcc LD=3D/opt/ELDK41/usr/bin/ppc=
_6xx-ld<br>
&gt; &gt; BUILD_CC=3D/usr/bin/gcc --target=3Dppc --host=3Di686<br>
&gt; &gt; CC=3D/opt/ELDK41/usr/bin/ppc_6xx-gcc<br>
&gt; &gt; TARGET_CC=3D/opt/ELDK41/usr/bin/ppc_6xx-gcc;<br>
&gt; &gt;<br>
&gt; &gt; The compilation was broken for PPC.<br>
&gt;<br>
&gt; Could you provide the compile errors that you are seeing?<br>
&gt;<br>
<br>
</div></div>Also, how do you know your kernel supports kexec?<br>
<font color=3D"#888888"><br>
-Matthew<br>
<br>
<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>Regards,<br>Radh=
a Krishna<br>&quot;Yesterday is history, Tomorrow is mystery, Today is gift=
&quot;<br>

--0016362843e80f35a2048b04dc8d--


--===============0498066463==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0498066463==--

