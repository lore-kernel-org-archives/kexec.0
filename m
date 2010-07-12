Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qw0-f49.google.com ([209.85.216.49])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OYCPg-0007vr-Rd
	for kexec@lists.infradead.org; Mon, 12 Jul 2010 06:22:51 +0000
Received: by qwe4 with SMTP id 4so1443719qwe.36
	for <kexec@lists.infradead.org>; Sun, 11 Jul 2010 23:22:47 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 12 Jul 2010 11:52:47 +0530
Message-ID: <AANLkTin0h-QftwCqLl0Yn7pi_JWlewC_VWSl01IPPwp-@mail.gmail.com>
Subject: Re: kexec for powerpc mpc83xx processors
From: krish <radhakrishna.p@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1983507141=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Matthew McClintock <msm@freescale.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

--===============1983507141==
Content-Type: multipart/alternative; boundary=0016364ecb5a004657048b2ac8b1

--0016364ecb5a004657048b2ac8b1
Content-Type: text/plain; charset=ISO-8859-1

Hi,

Actually, I have posted two emails, one for mpc83xx compilation error and
other for mpc85xx support to mailing list.
I have got response only for mpc85xx email. Anyway, the compilation problem
is common for both mpc83xx and mpc85xx.
Sorry for inconvenience created by me..

I have changed subject to "mpc83xx" instead "mpc85xx", and continue compile
error in this email.
I will post new request for "support of kexec for mpc85xx", if required.

"Makefile.libfdt" file is not present in the package.

I have used following link to download package.
http://www.kernel.org/pub/linux/kernel/people/horms/kexec-tools/testing/kexec-tools-2.0.2-rc1.tar.gz


On Sun, Jul 11, 2010 at 10:23 PM, Matthew McClintock <msm@freescale.com>wrote:

> On Sat, 2010-07-10 at 14:38 +0530, krish wrote:
> > Hi,
> >
> > I have gone through the kexec syscall implementation in kernel in the
> > view of mpc83xx processor. Currently, I am testing for mpc83xx based
> > card.
>
> Which are we talking about? You said mpc85xx NOT mpc83xx first, right?
>
> >
> > The compile error i got was:
> > kexec/arch/ppc/Makefile:4: kexec/arch/ppc/libfdt/Makefile.libfdt: No
> > such file or directory
>
> Well, does this file exist? If not you might not have a complete
> kexec-tools package.
>
> > make: *** No rule to make target
> > `kexec/arch/ppc/libfdt/Makefile.libfdt'.  Stop.
> >
> > I have commented the rule to include Makefile.libfdt in
> > "kexec/arch/ppc/Makefile", becuase the rules to compile source files
> > of libfdt folder are already present in the arch/ppc/Makefile.
> >
> > then i got following compile error:
> > /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
> > -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
> > -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
> > kexec/arch/ppc/kexec-ppc.o kexec/arch/ppc/kexec-ppc.c
> > kexec/arch/ppc/kexec-ppc.c:24:31: error: crashdump-powerpc.h: No such
> > file or directory
> > kexec/arch/ppc/kexec-ppc.c: In function 'get_devtree_details':
> > kexec/arch/ppc/kexec-ppc.c:389: warning: implicit declaration of
> > function 'add_usable_mem_rgns'
> > kexec/arch/ppc/kexec-ppc.c:390: error: 'KDUMP_BACKUP_LIMIT' undeclared
> > (first use in this function)
> > kexec/arch/ppc/kexec-ppc.c:390: error: (Each undeclared identifier is
> > reported only once
> > kexec/arch/ppc/kexec-ppc.c:390: error: for each function it appears
> > in.)
> >
> >
> > Below is the full dump of configure and make commands.
> > ==================================================================
> > [krishna@Amru kexec-tools-2.0.2-rc1]$ ./configure
> > --prefix=/home/krishna/work/KEXEC/kexec-tools-2.0.2-rc1/
> > CC=/opt/ELDK41/usr/bin/ppc_6xx-gcc LD=/opt/ELDK41/usr/bin/ppc_6xx-ld
> > BUILD_CC=/usr/bin/gcc --target=ppc --host=i686
> > TARGET_CC=/opt/ELDK41/usr/bin/ppc_6xx-gcc
> > configure: WARNING: If you wanted to set the --build type, don't use
> > --host.
> >     If a cross compiler is detected then cross compile mode will be
> > used.
> > checking build system type... i686-pc-linux-gnu
> > checking host system type... i686-pc-none
> > checking target system type... powerpc-unknown-none
> > checking for i686-gcc... /opt/ELDK41/usr/bin/ppc_6xx-gcc
> > checking whether the C compiler works... yes
> > checking for C compiler default output file name... a.out
> > checking for suffix of executables...
> > checking whether we are cross compiling... yes
> > checking for suffix of object files... o
> > checking whether we are using the GNU C compiler... yes
> > checking whether /opt/ELDK41/usr/bin/ppc_6xx-gcc accepts -g... yes
> > checking for /opt/ELDK41/usr/bin/ppc_6xx-gcc option to accept ISO
> > C89... none needed
> > checking for -gcc... /usr/bin/gcc
> > checking how to run the C
> > preprocessor... /opt/ELDK41/usr/bin/ppc_6xx-gcc -E
> > checking for i686-ld... /opt/ELDK41/usr/bin/ppc_6xx-ld
> > checking for i686-as... no
> > checking for as... as
> > configure: WARNING: using cross tools not prefixed with host triplet
> > checking for i686-objcopy... no
> > checking for objcopy... objcopy
> > checking for i686-ar... no
> > checking for ar... ar
> > checking for ppc-gcc... /opt/ELDK41/usr/bin/ppc_6xx-gcc
> > checking for ppc-ld... no
> > checking for powerpc-unknown-none-ld... no
> > checking for ld... ld
> > checking whether /opt/ELDK41/usr/bin/ppc_6xx-gcc accepts
> > -fno-zero-initialized-in-bss... Yes
> > checking for a BSD-compatible install... /usr/bin/install -c
> > checking for mkdir... mkdir
> > checking for rm... rm
> > checking for cp... cp
> > checking for ln... ln
> > checking for tar... tar
> > checking for rpmbuild... rpmbuild
> > checking for sed... sed
> > checking for find... find
> > checking for xargs... xargs
> > checking for dirname... dirname
> > checking for grep that handles long lines and -e... /bin/grep
> > checking for egrep... /bin/grep -E
> > checking for ANSI C header files... yes
> > checking for sys/types.h... yes
> > checking for sys/stat.h... yes
> > checking for stdlib.h... yes
> > checking for string.h... yes
> > checking for memory.h... yes
> > checking for strings.h... yes
> > checking for inttypes.h... yes
> > checking for stdint.h... yes
> > checking for unistd.h... yes
> > checking zlib.h usability... yes
> > checking zlib.h presence... yes
> > checking for zlib.h... yes
> > checking for inflateInit_ in -lz... yes
> > checking lzma.h usability... no
> > checking lzma.h presence... no
> > checking for lzma.h... no
> > checking xenctrl.h usability... no
> > checking xenctrl.h presence... no
> > checking for xenctrl.h... no
> > configure: creating ./config.status
> > config.status: creating Makefile
> > config.status: creating include/config.h
> >
> > output of "make" command
> > --------------------------------------------------------
> > /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
> > -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
> > -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
> > kexec/kexec.o kexec/kexec.c
> > /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
> > -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
> > -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
> > kexec/ifdown.o kexec/ifdown.c
> > /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
> > -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
> > -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
> > kexec/kexec-elf.o kexec/kexec-elf.c
> > /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
> > -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
> > -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
> > kexec/kexec-elf-exec.o kexec/kexec-elf-exec.c
> > /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
> > -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
> > -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
> > kexec/kexec-elf-core.o kexec/kexec-elf-core.c
> > /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
> > -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
> > -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
> > kexec/kexec-elf-rel.o kexec/kexec-elf-rel.c
> > /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
> > -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
> > -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
> > kexec/kexec-elf-boot.o kexec/kexec-elf-boot.c
> > /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
> > -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
> > -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
> > kexec/kexec-iomem.o kexec/kexec-iomem.c
> > /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
> > -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
> > -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
> > kexec/firmware_memmap.o kexec/firmware_memmap.c
> > /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
> > -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
> > -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
> > kexec/crashdump.o kexec/crashdump.c
> > /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
> > -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
> > -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
> > kexec/crashdump-xen.o kexec/crashdump-xen.c
> > /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
> > -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
> > -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
> > kexec/phys_arch.o kexec/phys_arch.c
> > /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
> > -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
> > -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
> > kexec/lzma.o kexec/lzma.c
> > /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
> > -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
> > -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
> > kexec/zlib.o kexec/zlib.c
> > /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
> > -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
> > -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
> > kexec/proc_iomem.o kexec/proc_iomem.c
> > /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
> > -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
> > -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
> > kexec/virt_to_phys.o kexec/virt_to_phys.c
> > /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
> > -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
> > -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
> > kexec/phys_to_virt.o kexec/phys_to_virt.c
> > /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
> > -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
> > -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
> > kexec/add_segment.o kexec/add_segment.c
> > /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
> > -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
> > -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
> > kexec/add_buffer.o kexec/add_buffer.c
> > /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
> > -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
> > -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
> > kexec/arch_reuse_initrd.o kexec/arch_reuse_initrd.c
> > /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
> > -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
> > -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
> > kexec/arch_init.o kexec/arch_init.c
> > /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall
> > -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/
> > -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include  -c -MD -o
> > kexec/arch/ppc/kexec-ppc.o kexec/arch/ppc/kexec-ppc.c
> > kexec/arch/ppc/kexec-ppc.c:24:31: error: crashdump-powerpc.h: No such
> > file or directory
> > kexec/arch/ppc/kexec-ppc.c: In function 'get_devtree_details':
> > kexec/arch/ppc/kexec-ppc.c:389: warning: implicit declaration of
> > function 'add_usable_mem_rgns'
> > kexec/arch/ppc/kexec-ppc.c:390: error: 'KDUMP_BACKUP_LIMIT' undeclared
> > (first use in this function)
> > kexec/arch/ppc/kexec-ppc.c:390: error: (Each undeclared identifier is
> > reported only once
> > kexec/arch/ppc/kexec-ppc.c:390: error: for each function it appears
> > in.)
> > make: *** [kexec/arch/ppc/kexec-ppc.o] Error 1
> > ==============================================================
> >
> >
> > On Sat, Jul 10, 2010 at 12:53 PM, Matthew McClintock
> > <msm@freescale.com> wrote:
> >
> >         On Sat, 2010-07-10 at 15:37 +0900, Simon Horman wrote:
> >         > On Sat, Jul 10, 2010 at 10:14:25AM +0530, krish wrote:
> >         > > Hi,
> >         > >
> >         > > I am using linux-2.6.34.1 version for both mpc83xx and
> >         mpc85xx processors.
> >         > > This version of kernel supports kexec for both 83xx and
> >         85xx processors.
> >         > > I have been using ELDK toolchain for PowerPC processors.
> >         > > I am using u-boot as boot loader and uImage & dtb images
> >         as Linux images.
> >         > >
> >         > > I have downloaded 2.0.2-rc1 package and tried to compile
> >         for mpc83xx.
> >         > > I have used following command to configure kexec-tools for
> >         ppc.
> >         > > ./configure
> >         --prefix=/home/krishna/work/kexec-tools-6dd624d/
> >         > > CC=/opt/ELDK41/usr/bin/ppc_6xx-gcc
> >         LD=/opt/ELDK41/usr/bin/ppc_6xx-ld
> >         > > BUILD_CC=/usr/bin/gcc --target=ppc --host=i686
> >         > > CC=/opt/ELDK41/usr/bin/ppc_6xx-gcc
> >         > > TARGET_CC=/opt/ELDK41/usr/bin/ppc_6xx-gcc;
> >         > >
> >         > > The compilation was broken for PPC.
> >         >
> >         > Could you provide the compile errors that you are seeing?
> >         >
> >
> >
> >         Also, how do you know your kernel supports kexec?
> >
> >         -Matthew
> >
> >
> >
> >
> >
> > --
> > Regards,
> > Radha Krishna
> > "Yesterday is history, Tomorrow is mystery, Today is gift"
>
> -M
>
>
>


-- 
Regards,
Radha Krishna
"Yesterday is history, Tomorrow is mystery, Today is gift"

--0016364ecb5a004657048b2ac8b1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>Actually, I have posted two emails, one for mpc83xx compilation =
error and other for mpc85xx support to mailing list.<br>I have got response=
 only for mpc85xx email. Anyway, the compilation problem is common for both=
 mpc83xx and mpc85xx.<br>
Sorry for inconvenience created by me..<br><br>I have changed subject to &q=
uot;mpc83xx&quot; instead &quot;mpc85xx&quot;, and continue compile error i=
n this email.<br>I will post new request for &quot;support of kexec for mpc=
85xx&quot;, if required.<br>
<br>&quot;Makefile.libfdt&quot; file is not present in the package.<br><br>=
I have used following link to download package.<br><a href=3D"http://www.ke=
rnel.org/pub/linux/kernel/people/horms/kexec-tools/testing/kexec-tools-2.0.=
2-rc1.tar.gz">http://www.kernel.org/pub/linux/kernel/people/horms/kexec-too=
ls/testing/kexec-tools-2.0.2-rc1.tar.gz</a><br>
<br><br><div class=3D"gmail_quote">On Sun, Jul 11, 2010 at 10:23 PM, Matthe=
w McClintock <span dir=3D"ltr">&lt;<a href=3D"mailto:msm@freescale.com">msm=
@freescale.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" s=
tyle=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8e=
x; padding-left: 1ex;">
<div class=3D"im">On Sat, 2010-07-10 at 14:38 +0530, krish wrote:<br>
&gt; Hi,<br>
&gt;<br>
</div><div class=3D"im">&gt; I have gone through the kexec syscall implemen=
tation in kernel in the<br>
&gt; view of mpc83xx processor. Currently, I am testing for mpc83xx based<b=
r>
&gt; card.<br>
<br>
</div>Which are we talking about? You said mpc85xx NOT mpc83xx first, right=
?<br>
<div class=3D"im"><br>
&gt;<br>
&gt; The compile error i got was:<br>
&gt; kexec/arch/ppc/Makefile:4: kexec/arch/ppc/libfdt/Makefile.libfdt: No<b=
r>
&gt; such file or directory<br>
<br>
</div>Well, does this file exist? If not you might not have a complete<br>
kexec-tools package.<br>
<div><div></div><div class=3D"h5"><br>
&gt; make: *** No rule to make target<br>
&gt; `kexec/arch/ppc/libfdt/Makefile.libfdt&#39;. =A0Stop.<br>
&gt;<br>
&gt; I have commented the rule to include Makefile.libfdt in<br>
&gt; &quot;kexec/arch/ppc/Makefile&quot;, becuase the rules to compile sour=
ce files<br>
&gt; of libfdt folder are already present in the arch/ppc/Makefile.<br>
&gt;<br>
&gt; then i got following compile error:<br>
&gt; /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall<br>
&gt; -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/<br>
&gt; -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include =A0-c -MD -o<br>
&gt; kexec/arch/ppc/kexec-ppc.o kexec/arch/ppc/kexec-ppc.c<br>
&gt; kexec/arch/ppc/kexec-ppc.c:24:31: error: crashdump-powerpc.h: No such<=
br>
&gt; file or directory<br>
&gt; kexec/arch/ppc/kexec-ppc.c: In function &#39;get_devtree_details&#39;:=
<br>
&gt; kexec/arch/ppc/kexec-ppc.c:389: warning: implicit declaration of<br>
&gt; function &#39;add_usable_mem_rgns&#39;<br>
&gt; kexec/arch/ppc/kexec-ppc.c:390: error: &#39;KDUMP_BACKUP_LIMIT&#39; un=
declared<br>
&gt; (first use in this function)<br>
&gt; kexec/arch/ppc/kexec-ppc.c:390: error: (Each undeclared identifier is<=
br>
&gt; reported only once<br>
&gt; kexec/arch/ppc/kexec-ppc.c:390: error: for each function it appears<br=
>
&gt; in.)<br>
&gt;<br>
&gt;<br>
&gt; Below is the full dump of configure and make commands.<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; [krishna@Amru kexec-tools-2.0.2-rc1]$ ./configure<br>
&gt; --prefix=3D/home/krishna/work/KEXEC/kexec-tools-2.0.2-rc1/<br>
&gt; CC=3D/opt/ELDK41/usr/bin/ppc_6xx-gcc LD=3D/opt/ELDK41/usr/bin/ppc_6xx-=
ld<br>
&gt; BUILD_CC=3D/usr/bin/gcc --target=3Dppc --host=3Di686<br>
&gt; TARGET_CC=3D/opt/ELDK41/usr/bin/ppc_6xx-gcc<br>
&gt; configure: WARNING: If you wanted to set the --build type, don&#39;t u=
se<br>
&gt; --host.<br>
&gt; =A0 =A0 If a cross compiler is detected then cross compile mode will b=
e<br>
&gt; used.<br>
&gt; checking build system type... i686-pc-linux-gnu<br>
&gt; checking host system type... i686-pc-none<br>
&gt; checking target system type... powerpc-unknown-none<br>
&gt; checking for i686-gcc... /opt/ELDK41/usr/bin/ppc_6xx-gcc<br>
&gt; checking whether the C compiler works... yes<br>
&gt; checking for C compiler default output file name... a.out<br>
&gt; checking for suffix of executables...<br>
&gt; checking whether we are cross compiling... yes<br>
&gt; checking for suffix of object files... o<br>
&gt; checking whether we are using the GNU C compiler... yes<br>
&gt; checking whether /opt/ELDK41/usr/bin/ppc_6xx-gcc accepts -g... yes<br>
&gt; checking for /opt/ELDK41/usr/bin/ppc_6xx-gcc option to accept ISO<br>
&gt; C89... none needed<br>
&gt; checking for -gcc... /usr/bin/gcc<br>
&gt; checking how to run the C<br>
&gt; preprocessor... /opt/ELDK41/usr/bin/ppc_6xx-gcc -E<br>
&gt; checking for i686-ld... /opt/ELDK41/usr/bin/ppc_6xx-ld<br>
&gt; checking for i686-as... no<br>
&gt; checking for as... as<br>
&gt; configure: WARNING: using cross tools not prefixed with host triplet<b=
r>
&gt; checking for i686-objcopy... no<br>
&gt; checking for objcopy... objcopy<br>
&gt; checking for i686-ar... no<br>
&gt; checking for ar... ar<br>
&gt; checking for ppc-gcc... /opt/ELDK41/usr/bin/ppc_6xx-gcc<br>
&gt; checking for ppc-ld... no<br>
&gt; checking for powerpc-unknown-none-ld... no<br>
&gt; checking for ld... ld<br>
&gt; checking whether /opt/ELDK41/usr/bin/ppc_6xx-gcc accepts<br>
&gt; -fno-zero-initialized-in-bss... Yes<br>
&gt; checking for a BSD-compatible install... /usr/bin/install -c<br>
&gt; checking for mkdir... mkdir<br>
&gt; checking for rm... rm<br>
&gt; checking for cp... cp<br>
&gt; checking for ln... ln<br>
&gt; checking for tar... tar<br>
&gt; checking for rpmbuild... rpmbuild<br>
&gt; checking for sed... sed<br>
&gt; checking for find... find<br>
&gt; checking for xargs... xargs<br>
&gt; checking for dirname... dirname<br>
&gt; checking for grep that handles long lines and -e... /bin/grep<br>
&gt; checking for egrep... /bin/grep -E<br>
&gt; checking for ANSI C header files... yes<br>
&gt; checking for sys/types.h... yes<br>
&gt; checking for sys/stat.h... yes<br>
&gt; checking for stdlib.h... yes<br>
&gt; checking for string.h... yes<br>
&gt; checking for memory.h... yes<br>
&gt; checking for strings.h... yes<br>
&gt; checking for inttypes.h... yes<br>
&gt; checking for stdint.h... yes<br>
&gt; checking for unistd.h... yes<br>
&gt; checking zlib.h usability... yes<br>
&gt; checking zlib.h presence... yes<br>
&gt; checking for zlib.h... yes<br>
&gt; checking for inflateInit_ in -lz... yes<br>
&gt; checking lzma.h usability... no<br>
&gt; checking lzma.h presence... no<br>
&gt; checking for lzma.h... no<br>
&gt; checking xenctrl.h usability... no<br>
&gt; checking xenctrl.h presence... no<br>
&gt; checking for xenctrl.h... no<br>
&gt; configure: creating ./config.status<br>
&gt; config.status: creating Makefile<br>
&gt; config.status: creating include/config.h<br>
&gt;<br>
&gt; output of &quot;make&quot; command<br>
&gt; --------------------------------------------------------<br>
&gt; /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall<br>
&gt; -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/<br>
&gt; -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include =A0-c -MD -o<br>
&gt; kexec/kexec.o kexec/kexec.c<br>
&gt; /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall<br>
&gt; -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/<br>
&gt; -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include =A0-c -MD -o<br>
&gt; kexec/ifdown.o kexec/ifdown.c<br>
&gt; /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall<br>
&gt; -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/<br>
&gt; -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include =A0-c -MD -o<br>
&gt; kexec/kexec-elf.o kexec/kexec-elf.c<br>
&gt; /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall<br>
&gt; -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/<br>
&gt; -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include =A0-c -MD -o<br>
&gt; kexec/kexec-elf-exec.o kexec/kexec-elf-exec.c<br>
&gt; /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall<br>
&gt; -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/<br>
&gt; -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include =A0-c -MD -o<br>
&gt; kexec/kexec-elf-core.o kexec/kexec-elf-core.c<br>
&gt; /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall<br>
&gt; -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/<br>
&gt; -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include =A0-c -MD -o<br>
&gt; kexec/kexec-elf-rel.o kexec/kexec-elf-rel.c<br>
&gt; /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall<br>
&gt; -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/<br>
&gt; -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include =A0-c -MD -o<br>
&gt; kexec/kexec-elf-boot.o kexec/kexec-elf-boot.c<br>
&gt; /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall<br>
&gt; -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/<br>
&gt; -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include =A0-c -MD -o<br>
&gt; kexec/kexec-iomem.o kexec/kexec-iomem.c<br>
&gt; /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall<br>
&gt; -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/<br>
&gt; -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include =A0-c -MD -o<br>
&gt; kexec/firmware_memmap.o kexec/firmware_memmap.c<br>
&gt; /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall<br>
&gt; -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/<br>
&gt; -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include =A0-c -MD -o<br>
&gt; kexec/crashdump.o kexec/crashdump.c<br>
&gt; /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall<br>
&gt; -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/<br>
&gt; -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include =A0-c -MD -o<br>
&gt; kexec/crashdump-xen.o kexec/crashdump-xen.c<br>
&gt; /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall<br>
&gt; -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/<br>
&gt; -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include =A0-c -MD -o<br>
&gt; kexec/phys_arch.o kexec/phys_arch.c<br>
&gt; /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall<br>
&gt; -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/<br>
&gt; -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include =A0-c -MD -o<br>
&gt; kexec/lzma.o kexec/lzma.c<br>
&gt; /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall<br>
&gt; -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/<br>
&gt; -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include =A0-c -MD -o<br>
&gt; kexec/zlib.o kexec/zlib.c<br>
&gt; /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall<br>
&gt; -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/<br>
&gt; -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include =A0-c -MD -o<br>
&gt; kexec/proc_iomem.o kexec/proc_iomem.c<br>
&gt; /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall<br>
&gt; -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/<br>
&gt; -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include =A0-c -MD -o<br>
&gt; kexec/virt_to_phys.o kexec/virt_to_phys.c<br>
&gt; /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall<br>
&gt; -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/<br>
&gt; -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include =A0-c -MD -o<br>
&gt; kexec/phys_to_virt.o kexec/phys_to_virt.c<br>
&gt; /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall<br>
&gt; -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/<br>
&gt; -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include =A0-c -MD -o<br>
&gt; kexec/add_segment.o kexec/add_segment.c<br>
&gt; /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall<br>
&gt; -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/<br>
&gt; -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include =A0-c -MD -o<br>
&gt; kexec/add_buffer.o kexec/add_buffer.c<br>
&gt; /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall<br>
&gt; -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/<br>
&gt; -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include =A0-c -MD -o<br>
&gt; kexec/arch_reuse_initrd.o kexec/arch_reuse_initrd.c<br>
&gt; /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall<br>
&gt; -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/<br>
&gt; -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include =A0-c -MD -o<br>
&gt; kexec/arch_init.o kexec/arch_init.c<br>
&gt; /opt/ELDK41/usr/bin/ppc_6xx-gcc -g -O2 -fno-strict-aliasing -Wall<br>
&gt; -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/<br>
&gt; -I./kexec/arch/ppc/libfdt -I./kexec/arch/ppc/include =A0-c -MD -o<br>
&gt; kexec/arch/ppc/kexec-ppc.o kexec/arch/ppc/kexec-ppc.c<br>
&gt; kexec/arch/ppc/kexec-ppc.c:24:31: error: crashdump-powerpc.h: No such<=
br>
&gt; file or directory<br>
&gt; kexec/arch/ppc/kexec-ppc.c: In function &#39;get_devtree_details&#39;:=
<br>
&gt; kexec/arch/ppc/kexec-ppc.c:389: warning: implicit declaration of<br>
&gt; function &#39;add_usable_mem_rgns&#39;<br>
&gt; kexec/arch/ppc/kexec-ppc.c:390: error: &#39;KDUMP_BACKUP_LIMIT&#39; un=
declared<br>
&gt; (first use in this function)<br>
&gt; kexec/arch/ppc/kexec-ppc.c:390: error: (Each undeclared identifier is<=
br>
&gt; reported only once<br>
&gt; kexec/arch/ppc/kexec-ppc.c:390: error: for each function it appears<br=
>
&gt; in.)<br>
&gt; make: *** [kexec/arch/ppc/kexec-ppc.o] Error 1<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt;<br>
&gt;<br>
&gt; On Sat, Jul 10, 2010 at 12:53 PM, Matthew McClintock<br>
&gt; &lt;<a href=3D"mailto:msm@freescale.com">msm@freescale.com</a>&gt; wro=
te:<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 On Sat, 2010-07-10 at 15:37 +0900, Simon Horman wrote:=
<br>
&gt; =A0 =A0 =A0 =A0 &gt; On Sat, Jul 10, 2010 at 10:14:25AM +0530, krish w=
rote:<br>
&gt; =A0 =A0 =A0 =A0 &gt; &gt; Hi,<br>
&gt; =A0 =A0 =A0 =A0 &gt; &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; &gt; I am using linux-2.6.34.1 version for both m=
pc83xx and<br>
&gt; =A0 =A0 =A0 =A0 mpc85xx processors.<br>
&gt; =A0 =A0 =A0 =A0 &gt; &gt; This version of kernel supports kexec for bo=
th 83xx and<br>
&gt; =A0 =A0 =A0 =A0 85xx processors.<br>
&gt; =A0 =A0 =A0 =A0 &gt; &gt; I have been using ELDK toolchain for PowerPC=
 processors.<br>
&gt; =A0 =A0 =A0 =A0 &gt; &gt; I am using u-boot as boot loader and uImage =
&amp; dtb images<br>
&gt; =A0 =A0 =A0 =A0 as Linux images.<br>
&gt; =A0 =A0 =A0 =A0 &gt; &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; &gt; I have downloaded 2.0.2-rc1 package and trie=
d to compile<br>
&gt; =A0 =A0 =A0 =A0 for mpc83xx.<br>
&gt; =A0 =A0 =A0 =A0 &gt; &gt; I have used following command to configure k=
exec-tools for<br>
&gt; =A0 =A0 =A0 =A0 ppc.<br>
&gt; =A0 =A0 =A0 =A0 &gt; &gt; ./configure<br>
&gt; =A0 =A0 =A0 =A0 --prefix=3D/home/krishna/work/kexec-tools-6dd624d/<br>
&gt; =A0 =A0 =A0 =A0 &gt; &gt; CC=3D/opt/ELDK41/usr/bin/ppc_6xx-gcc<br>
&gt; =A0 =A0 =A0 =A0 LD=3D/opt/ELDK41/usr/bin/ppc_6xx-ld<br>
&gt; =A0 =A0 =A0 =A0 &gt; &gt; BUILD_CC=3D/usr/bin/gcc --target=3Dppc --hos=
t=3Di686<br>
&gt; =A0 =A0 =A0 =A0 &gt; &gt; CC=3D/opt/ELDK41/usr/bin/ppc_6xx-gcc<br>
&gt; =A0 =A0 =A0 =A0 &gt; &gt; TARGET_CC=3D/opt/ELDK41/usr/bin/ppc_6xx-gcc;=
<br>
&gt; =A0 =A0 =A0 =A0 &gt; &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; &gt; The compilation was broken for PPC.<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; Could you provide the compile errors that you are=
 seeing?<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Also, how do you know your kernel supports kexec?<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 -Matthew<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; Regards,<br>
&gt; Radha Krishna<br>
&gt; &quot;Yesterday is history, Tomorrow is mystery, Today is gift&quot;<b=
r>
<br>
</div></div><font color=3D"#888888">-M<br>
<br>
<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>Regards,<br>Radh=
a Krishna<br>&quot;Yesterday is history, Tomorrow is mystery, Today is gift=
&quot;<br>

--0016364ecb5a004657048b2ac8b1--


--===============1983507141==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1983507141==--

