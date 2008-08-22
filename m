Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KWelN-0007u4-HX
	for kexec@lists.infradead.org; Fri, 22 Aug 2008 22:05:45 +0000
Subject: Re: Trying to test my gart/iommu vmcore problem on RH
From: Bob Montgomery <bob.montgomery@hp.com>
In-Reply-To: <m1wsib3raq.fsf@frodo.ebiederm.org>
References: <1218138156.3361.386.camel@amd.troyhebe>
	<20080808014024.GB3911@redhat.com>	<1218750773.3361.425.camel@amd.troyhebe>
	<20080815131359.GA10208@redhat.com>
	<1219081942.3361.436.camel@amd.troyhebe>
	<20080819134748.GC18972@redhat.com> <m1wsib3raq.fsf@frodo.ebiederm.org>
Date: Fri, 22 Aug 2008 16:05:51 -0600
Message-Id: <1219442751.3361.459.camel@amd.troyhebe>
Mime-Version: 1.0
Reply-To: bob.montgomery@hp.com
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Heber, Troy" <troy.heber@hp.com>, "Loftin, Terry" <terry.loftin@hp.com>, Kexec Mailing List <kexec@lists.infradead.org>, Vivek Goyal <vgoyal@redhat.com>

On Thu, 2008-08-21 at 04:50 +0000, Eric W. Biederman wrote:
> Vivek Goyal <vgoyal@redhat.com> writes:

> > Few options Bob is considering are.
> >
> > - Update "e820" memory map to mark GART aperture as reserved, which will
> >   be reflected in /proc/iomem also. Kexec-tools will not pass reserved
> >   area to second kernel and it will not try to dump this area.
> >
> >
> > - Mark GART aperture as "GART aperture" in /proc/iomem and modify
> >   kexec-tools to filter out this memroy from memory map passed to second
> >   kernel.
> 
> 
> We should definitely reserve the resource, and it should definitely
> show up in /proc/iomem.

Reserving it as a child resource called "GART" in a "System RAM"
resource is already in newer kernels than mine (at least in by 2.6.26).
I haven't seen that kexec-tools does anything with that yet.
kexec-tools looks for "Crash kernel" in /proc/iomem now and explicitly
excludes that area.

Example:
000f0000-000fffff : System ROM
00100000-cfe4ffff : System RAM
  00200000-0042635a : Kernel code
  0042635b-00592037 : Kernel data
  01000000-08ffffff : Crash kernel
  0c000000-0fffffff : GART
cfe50000-cfe57fff : ACPI Tables
cfe58000-cfffffff : reserved

If it could be "reserved" earlier, so it isn't a child resource of a
System Ram area, but a "reserved" area that divides two "System RAM"
areas, then the current kexec-tools would exclude it (like it excludes
all "reserved" areas from the /proc/vmcore map, and it would no longer
be possible to trigger the MCE (or the mysterious hang) by reading
from /proc/vmcore.  But currently (in my older kernel) the original
iomem_resource is constructed from the e820 map before I know where (and
how big) the aperture will be created.

But either way we fix it in iomem to exclude it from /proc/vmcore, a
read of /dev/oldmem in the aperture area would still trigger the MCE.
At least it does on my system. 

> 
> > - Disable cpu side GART access in first kernel so that even if second
> >   kernel tries to access it, it does not run into isseus.

This has the advantage of "fixing" accesses through both /proc/vmcore
and /dev/oldmem.   And for me, it's an easy patch to pci-gart.c in
init_k8_gatt that just sets bit 4 instead of clearing both 4 and 5:

-               ctl |= 1;
-               ctl &= ~((1<<4) | (1<<5));
+               ctl |= 1;       /* set GartEn */
+               ctl |= (1<<4);  /* set DisGartCpu */
+               ctl &= ~(1<<5); /* clear DisGartIO */

> 
> This is an interesting one.  When I looked at this years ago I had the
> feeling that if we did this we could actually always use a 2G Aperture
> at a fixed address, and require going through the gart for all of lowmem.

During discussions here, a colleague suggested that with CPU-side access
of the aperture disabled, we could allocate the crash kernel in the
wasted memory "under" the aperture.
> 
> But that is a little more than we are talking about.
Yes, also.
> 
> Eric
Bob Montgomery


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
