Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XdwXn-0000IU-MA
 for kexec@lists.infradead.org; Tue, 14 Oct 2014 07:29:20 +0000
Date: Tue, 14 Oct 2014 15:28:52 +0800
From: "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [PATCH] makedumpfile: Enable --mem-usage for s390x
Message-ID: <20141014072852.GB16068@dhcp-16-116.nay.redhat.com>
References: <20140926101057.14549a12@holzheu>
 <20140926085546.GA30346@dhcp-16-116.nay.redhat.com>
 <20140926133441.5e58303c@holzheu>
 <20140929090432.GA9989@dhcp-16-116.nay.redhat.com>
 <20140929151413.4e9bd1ab@holzheu>
 <20140930090201.GB9989@dhcp-16-116.nay.redhat.com>
 <20141001185953.66c6ae9d@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE9701D4D5E4@BPXM01GP.gisp.nec.co.jp>
 <20141010142310.4c488f6a@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE9701D4E4E4@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701D4E4E4@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "holzheu@linux.vnet.ibm.com" <holzheu@linux.vnet.ibm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On 10/14/14 at 07:19am, Atsushi Kumagai wrote:
> >> I think the Michael's first idea below is better since it implements
> >> is_real_addr() only for --mem-usage as a common function for all
> >> architectures, it's explicit design.
> >>
> >> >@@ -854,7 +854,7 @@ int get_kcore_dump_loads(void)
> >> >
> >> > 	for (i = 0; i < num_pt_loads; ++i) {
> >> > 		struct pt_load_segment *p = &pt_loads[i];
> >> >-		if (is_vmalloc_addr(p->virt_start))
> >> >+		if (!is_real_addr(p->virt_start))
> >> > 			continue;
> >> > 		loads++;
> >> > 	}
> >>
> >> However, this code will not work since the argument of is_real_addr()
> >> must be physical address. Even unluckily, /proc/kcore's PT_LOAD looks
> >> useless for VtoP converting because PhysAddr is always 0:
> >>
> >> Program Headers:
> >>   Type           Offset             VirtAddr           PhysAddr
> >>                  FileSiz            MemSiz              Flags  Align
> >>   NOTE           0x00000000000002a8 0x0000000000000000 0x0000000000000000
> >>                  0x0000000000000a84 0x0000000000000000         0
> >>   LOAD           0x00007fffff601000 0xffffffffff600000 0x0000000000000000
> >>                  0x0000000000001000 0x0000000000001000  RWE    1000
> >>   LOAD           0x00007fff81001000 0xffffffff81000000 0x0000000000000000
> >>                  0x0000000000a1b000 0x0000000000a1b000  RWE    1000
> >>   LOAD           0x0000490000001000 0xffffc90000000000 0x0000000000000000
> >>                  0x00001fffffffffff 0x00001fffffffffff  RWE    1000
> >>   LOAD           0x00007fffa0001000 0xffffffffa0000000 0x0000000000000000
> >>                  0x000000005f000000 0x000000005f000000  RWE    1000
> >>   ...
> >>
> >>
> >> So the way using /proc/iomem seems inappropriate, we have to consider other
> >> approaches (but I still don't have any good ideas...)
> >
> >Hello Atsushi,
> >
> >Hmmm ok, sure. For x86 using /proc/iomem does not work because there is no 1:1
> >mapping for the kernel address space. The kernel/real memory is mapped somewhere
> >at the end, right?
> 
> Exactly.
> 
> >For s390 we have a 1:1 mapping for the kernel physical memory that starts with
> >zero. Therefore IMHO we could use /proc/iomem. For example, on my s390x system
> >with 1GB memory and 256MB crashkernel:
> >
> >$ cat /proc/iomem
> >00000000-2fffffff : System RAM
> >  00000000-007ddd4b : Kernel code
> >  007ddd4c-00bfcc5f : Kernel data
> >  00e18000-01c28b1f : Kernel bss
> >30000000-3fffffff : Crash kernel
> >
> >$ objdump -h /proc/kcore
> >...
> >  Type           Offset             VirtAddr           PhysAddr
> >                 FileSiz            MemSiz              Flags  Align
> >  NOTE           0x0000000000000158 0x0000000000000000 0x0000000000000000
> >                 0x00000000000027fc 0x0000000000000000         0
> >  LOAD           0x000003e080003000 0x000003e080000000 0x0000000000000000
> >                 0x0000001f00000000 0x0000001f00000000  RWE    1000
> >  LOAD           0x000003ff80003000 0x000003ff80000000 0x0000000000000000
> >                 0x0000000080000000 0x0000000080000000  RWE    1000
> >  LOAD           0x0000000000003000 0x0000000000000000 0x0000000000000000
> >                 0x0000000030000000 0x0000000030000000  RWE    1000
> >  LOAD           0x000003d100003000 0x000003d100000000 0x0000000000000000
> >                 0x0000000000c00000 0x0000000000c00000  RWE    1000
> >
> >So in that case every /proc/kcore load that is below 0x30000000 must
> >be real memory.
> >
> >Michael
> 
> I understand why your patch works on s390x, so how about this way ?
> 
>  1. Define "is_phys_addr()" for --mem-usage.
>  2. Implement is_phys_addr() using is_iomem_phys_addr() for s390x
>     while x86_64 uses is_vmalloc_addr_x86_64().
>  3. Use is_phys_addr() instead of is_vmalloc_addr() in get_kcore_dump_loads().

Yeah, this is a working way. In fact I can change to use /proc/iomem to
get phys mem region, then filter each program loads of kcore by these
phys mem region. Since phys can be converted to virt by adding
PAGE_OFFSET, for x86_64 and s390x PAGE_OFFSET is specific. But I am not
sure if other ARCH have the same problem, e.g their PAGE_OFFSET is not a
fixed value just as VMALLOC_START in s390x.

Anyway, I think Atsushi's suggestion is good.

Thanks
Baoquan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
