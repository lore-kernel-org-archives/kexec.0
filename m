Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UG4w6-0001tG-AX
 for kexec@lists.infradead.org; Thu, 14 Mar 2013 09:58:59 +0000
Date: Thu, 14 Mar 2013 10:58:52 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 04/13] kexec: use _ALIGN* to make the logic clear
Message-ID: <20130314095852.GY11196@verge.net.au>
References: <5140B511.7020109@gmail.com> <5140B6E0.1080202@gmail.com>
 <20130314090805.GH11196@verge.net.au>
 <20130314094950.GR11196@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130314094950.GR11196@verge.net.au>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Zhang Yanfei <zhangyanfei.yes@gmail.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Thu, Mar 14, 2013 at 10:49:51AM +0100, Simon Horman wrote:
> On Thu, Mar 14, 2013 at 10:08:06AM +0100, Simon Horman wrote:
> > On Thu, Mar 14, 2013 at 01:26:56AM +0800, Zhang Yanfei wrote:
> > > From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
> > > 
> > > By replacing all the explicit align opertions with marco _ALIGN*,
> > > the code logic could be more clear.
> > 
> > Not a big deal, but I believe this patch needs to come after
> > the arm changes in the series in order to avoid breaking the build
> > on that architecture.
> 
> I have applied this as the last patch of this series that I have applied.

Actually, I take that back.

I am also seeing problems with this patch on ppc.
I have dropped this patch for now.

powerpc-linux-gnu-ar: creating libutil.a
powerpc-linux-gnu-gcc -L/lib  -o build/sbin/kexec kexec/kexec.o kexec/ifdown.o kexec/kexec-elf.o kexec/kexec-elf-exec.o kexec/kexec-elf-core.o kexec/kexec-elf-rel.o kexec/kexec-elf-boot.o kexec/kexec-iomem.o kexec/firmware_memmap.o kexec/crashdump.o kexec/crashdump-xen.o kexec/phys_arch.o kexec/kernel_version.o kexec/lzma.o kexec/zlib.o kexec/proc_iomem.o kexec/virt_to_phys.o kexec/phys_to_virt.o kexec/add_segment.o kexec/add_buffer.o kexec/kexec-uImage.o kexec/arch/ppc/kexec-ppc.o kexec/arch/ppc/kexec-elf-ppc.o kexec/arch/ppc/kexec-elf-rel-ppc.o kexec/arch/ppc/kexec-dol-ppc.o kexec/arch/ppc/kexec-uImage-ppc.o kexec/arch/ppc/ppc-setup-simple.o kexec/arch/ppc/ppc-setup-dol.o kexec/arch/ppc/fixup_dtb.o kexec/arch/ppc/fs2dt.o kexec/arch/ppc/crashdump-powerpc.o kexec/libfdt/fdt.o kexec/libfdt/fdt_ro.o kexec/libfdt/fdt_wip.o kexec/libfdt/fdt_sw.o kexec/libfdt/fdt_rw.o kexec/libfdt/fdt_strerror.o kexec/arch/ppc/libfdt-wrapper.o kexec/purgatory.o libutil.a -Wall -Wextra -Wpointer-arith -Wwrite-strings -Wformat -O2 -fomit-frame-pointer -pipe -fno-strict-aliasing -Wall -Wstrict-prototypes 
kexec/libfdt/fdt.o: In function `fdt_next_tag':
fdt.c:(.text+0x304): undefined reference to `_ALIGN'
kexec/libfdt/fdt_sw.o: In function `fdt_begin_node':
fdt_sw.c:(.text+0x4f4): undefined reference to `_ALIGN'
kexec/libfdt/fdt_sw.o: In function `fdt_property':
fdt_sw.c:(.text+0x648): undefined reference to `_ALIGN'
kexec/libfdt/fdt_sw.o: In function `fdt_create':
fdt_sw.c:(.text+0x744): undefined reference to `_ALIGN'
kexec/libfdt/fdt_rw.o: In function `_fdt_blocks_misordered':
fdt_rw.c:(.text+0x40): undefined reference to `_ALIGN'
kexec/libfdt/fdt_rw.o:fdt_rw.c:(.text+0x19c): more undefined references to `_ALIGN' follow
collect2: ld returned 1 exit status

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
