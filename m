Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from qw-out-1920.google.com ([74.125.92.149])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Me7TB-0000cu-V8
	for kexec@lists.infradead.org; Thu, 20 Aug 2009 13:14:26 +0000
Received: by qw-out-1920.google.com with SMTP id 5so2912802qwf.24
	for <kexec@lists.infradead.org>; Thu, 20 Aug 2009 06:14:19 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 20 Aug 2009 22:14:19 +0900
Message-ID: <aec7e5c30908200614j68c1ad6ci7a3d8d1b9f98d08b@mail.gmail.com>
Subject: kexec-tools-2.0.1 and CFLAGS
From: Magnus Damm <magnus.damm@gmail.com>
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
To: kexec@lists.infradead.org
Cc: horms@verge.net.au

Hi Simon, Everyone,

Kexec-tools 2.0.1 seems to build only with optimization enabled. If I
set CFLAGS before calling configure and remove the "-O2" then the code
won't link properly. I found it while cross compiling for SuperH, but
it's most likely an issue on other platforms as well. Have a look at
the "-O0" below:

 $ AR=_ar CC=_gcc CFLAGS="-O0" LDFLAGS="-static" ./configure
--prefix=/ --host="sh3-linux" --without-zlib --without-xen
....
$ make
...
_gcc -static  -o build/sbin/kexec kexec/kexec.o kexec/ifdown.o
kexec/kexec-elf.o kexec/kexec-elf-exec.o kexec/kexec-elf-core.o
kexec/kexec-elf-rel.o kexec/kexec-elf-boot.o kexec/kexec-iomem.o
kexec/firmware_memmap.o kexec/crashdump.o kexec/crashdump-xen.o
kexec/phys_arch.o kexec/proc_iomem.o kexec/arch_reuse_initrd.o
kexec/arch/sh/kexec-sh.o kexec/arch/sh/kexec-zImage-sh.o
kexec/arch/sh/kexec-netbsd-sh.o kexec/arch/sh/kexec-elf-sh.o
kexec/arch/sh/kexec-elf-rel-sh.o kexec/arch/sh/netbsd_booter.o
kexec/arch/sh/crashdump-sh.o kexec/purgatory.o libutil.a
kexec/arch/sh/kexec-elf-rel-sh.o: In function `machine_apply_elf_rel':
kexec-elf-rel-sh.c:(.text+0x1b0): undefined reference to
`bad_unaligned_access_length'
kexec-elf-rel-sh.c:(.text+0x288): undefined reference to
`bad_unaligned_access_length'
collect2: ld returned 1 exit status
make: *** [build/sbin/kexec] Error 1

This issue is most likely related to get_unaligned() and
put_unaligned() having bad_unaligned_access_length() in their default
case that never gets optimized away.

Anyway, not very important. But at least you know now. =)

Cheers,

/ magnus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
