Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]
	helo=relay.sgi.com)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KYPqO-0006zd-9m
	for kexec@lists.infradead.org; Wed, 27 Aug 2008 18:34:12 +0000
Date: Wed, 27 Aug 2008 13:34:13 -0500
From: Cliff Wickman <cpw@sgi.com>
Subject: Re: kexec -p loads
Message-ID: <20080827183413.GA22700@sgi.com>
References: <E1KY6n1-00014H-Qi@eag09.americas.sgi.com>
	<20080827133915.GA3694@redhat.com>
	<20080827154333.2298e414@halley.suse.de>
	<20080827152815.GC3694@redhat.com>
	<20080827173035.71358a1f@halley.suse.de>
	<20080827153622.GD3694@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080827153622.GD3694@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Bernhard Walle <bwalle@suse.de>, Kexec Mailing List <kexec@lists.infradead.org>


On Wed, Aug 27, 2008 at 11:36:22AM -0400, Vivek Goyal wrote:
> On Wed, Aug 27, 2008 at 05:30:35PM +0200, Bernhard Walle wrote:
> > * Vivek Goyal [2008-08-27 11:28]:
> > > > > 
> > > > > > I have this debugging output from my kexec:
> > > > > > 
> > > > > > cpw: elf_x86_64_load returning entry:0x1550
> > > > > > cpw: after call to file_type[i].load: nr_segments:6 entry:0x1550
> > > > > > kexec_load: entry = 0x1550 flags = 1
> > > > > > nr_segments = 6
> > > > > > segment[0].buf   = 0x5237a0
> > > > > > segment[0].bufsz = 7100
> > > > > > segment[0].mem   = 0x1000
> > > > > > segment[0].memsz = 9000
> > > > > > 
> > > > > > segment[1].buf   = 0x52aaf0
> > > > > > segment[1].bufsz = 1000
> > > > > > segment[1].mem   = 0xa000
> > > > > > segment[1].memsz = 1000
> > > > > > 
> > > > > 
> > > > > I think above two segments are not being loaded at right place. Looks like
> > > > > kexec-tools decided to load first one at physical address 0x1000 and other at
> > > > > physical address 0xa000. For crash kernel this is not right. It should
> > > > > come out of reserved memory area and that's why you are encountering the
> > > > > error.
> > > > 
> > > > Relocatability in ELF image never worked on x86_64 because of GDB but
> > > > (so the binary was marked as ET_EXEC instead of ET_DYN).
> > > > 
> > > > You have to use bzImage for kdump in any case.
> > > 
> > > True that vmlinux is not relocatable. But one can always compile the
> > > vmlinux for a fixed physical address (Address in reserved region) and then
> > > use it?  In this case his vmlinux seems to have been compiled for physical
> > > address 16MB. Which should be usable if there is a reserved memory region
> > > at 16MB.
> > 
> > Of course, that's true. I just thought when Cliff uses the same kernel
> > for "kexec -l" and "kexec -p", then it's the "normal" kernel. But I
> > didn't calculate the numbers.
> > 
> > 
> 
> Its litle tricky. I think one can always do both "kexec -l" and "kexec -p"
> on a vmlinux which has been built for kdump (for reserved region).
> 
> But one can not do "kexec -p" on normal kernel vmlinux.
> 
> So I am assuming that Cliff is running into first case. But he can tell
> us more. 
> 
> Cliff, is it same vmlinux which you use for first kernel or a different
> vmlinux compiled for dump capture.

Sorry for the lag.  I was working on the problem and not watching my mail.

I'm using two different kernels.
The kdump vmlinux is compiled with
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000

I'm using  kexec-tools-1.101

Here's the head of iomem:
cleopatra1:/tmp/cpw # cat /proc/iomem
00000000-0009bbff : System RAM
0009bc00-0009ffff : reserved
000d0000-000d7fff : reserved
000e4000-000fffff : reserved
00100000-cff5ffff : System RAM
  00200000-005c6448 : Kernel code
  005c6449-007da867 : Kernel data
  0088d000-0094b447 : Kernel bss
  01000000-04ffffff : Crash kernel
cff60000-cff68fff : ACPI Tables
cff69000-cff7ffff : ACPI Non-volatile Storage
cff80000-cfffffff : reserved
d0000000-d7ffffff : PCI Bus 0000:08
  d0000000-d7ffffff : 0000:08:01.0

I do have Bernhard's patch applied:

--- a/arch/x86/kernel/setup_64.c
+++ b/arch/x86/kernel/setup_64.c
@@ -444,6 +444,12 @@ void __init setup_arch(char **cmdline_p)
        contig_initmem_init(0, end_pfn);
 #endif

+       /*
+        * dma32_reserve_bootmem() allocates bootmem which may conflict
+        * with the crashkernel command line, so do that before
+        */
+       reserve_crashkernel();
+
        dma32_reserve_bootmem();

 #ifdef CONFIG_ACPI_SLEEP
@@ -484,7 +490,6 @@ void __init setup_arch(char **cmdline_p)
                }
        }
 #endif
-       reserve_crashkernel();

        reserve_ibft_region();



I'll try some printf's in  mem-max and mem-min inside locate_hole() as
you suggested.

-Cliff
-- 
Cliff Wickman
Silicon Graphics, Inc.
cpw@sgi.com
(651) 683-3824

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
