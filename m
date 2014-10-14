Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XdwlQ-0004yk-Gu
 for kexec@lists.infradead.org; Tue, 14 Oct 2014 07:43:25 +0000
Date: Tue, 14 Oct 2014 15:42:57 +0800
From: "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [PATCH] makedumpfile: Enable --mem-usage for s390x
Message-ID: <20141014074257.GC16068@dhcp-16-116.nay.redhat.com>
References: <20140926085546.GA30346@dhcp-16-116.nay.redhat.com>
 <20140926133441.5e58303c@holzheu>
 <20140929090432.GA9989@dhcp-16-116.nay.redhat.com>
 <20140929151413.4e9bd1ab@holzheu>
 <20140930090201.GB9989@dhcp-16-116.nay.redhat.com>
 <20141001185953.66c6ae9d@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE9701D4D5E4@BPXM01GP.gisp.nec.co.jp>
 <20141010142310.4c488f6a@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE9701D4E4E4@BPXM01GP.gisp.nec.co.jp>
 <20141014072852.GB16068@dhcp-16-116.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20141014072852.GB16068@dhcp-16-116.nay.redhat.com>
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

On 10/14/14 at 03:28pm, Baoquan He wrote:
> On 10/14/14 at 07:19am, Atsushi Kumagai wrote:
> > >> I think the Michael's first idea below is better since it implements
> > >> is_real_addr() only for --mem-usage as a common function for all
> > >> architectures, it's explicit design.
> > >>
> > >> >@@ -854,7 +854,7 @@ int get_kcore_dump_loads(void)
> > >> >
> > >> > 	for (i = 0; i < num_pt_loads; ++i) {
> > >> > 		struct pt_load_segment *p = &pt_loads[i];
> > >> >-		if (is_vmalloc_addr(p->virt_start))
> > >> >+		if (!is_real_addr(p->virt_start))
> > >> > 			continue;
> > >> > 		loads++;
> > >> > 	}
> > >>
> > >> However, this code will not work since the argument of is_real_addr()
> > >> must be physical address. Even unluckily, /proc/kcore's PT_LOAD looks
> > >> useless for VtoP converting because PhysAddr is always 0:
> > >>
> > >> Program Headers:
> > >>   Type           Offset             VirtAddr           PhysAddr
> > >>                  FileSiz            MemSiz              Flags  Align
> > >>   NOTE           0x00000000000002a8 0x0000000000000000 0x0000000000000000
> > >>                  0x0000000000000a84 0x0000000000000000         0
> > >>   LOAD           0x00007fffff601000 0xffffffffff600000 0x0000000000000000
> > >>                  0x0000000000001000 0x0000000000001000  RWE    1000
> > >>   LOAD           0x00007fff81001000 0xffffffff81000000 0x0000000000000000
> > >>                  0x0000000000a1b000 0x0000000000a1b000  RWE    1000
> > >>   LOAD           0x0000490000001000 0xffffc90000000000 0x0000000000000000
> > >>                  0x00001fffffffffff 0x00001fffffffffff  RWE    1000
> > >>   LOAD           0x00007fffa0001000 0xffffffffa0000000 0x0000000000000000
> > >>                  0x000000005f000000 0x000000005f000000  RWE    1000
> > >>   ...
> > >>
> > >>
> > >> So the way using /proc/iomem seems inappropriate, we have to consider other
> > >> approaches (but I still don't have any good ideas...)
> > >
> > >Hello Atsushi,
> > >
> > >Hmmm ok, sure. For x86 using /proc/iomem does not work because there is no 1:1
> > >mapping for the kernel address space. The kernel/real memory is mapped somewhere
> > >at the end, right?
> > 
> > Exactly.

Well, forget to say. I think x86 and x86_64 can use this way either.
Since they are also linear mapping though it's not 1:1 mapping. phys can
be converted to vrit by adding page_offset directly.


E.g x86_64, the PAGE_OFFSET is 0xffff880000000000, then I can very
easily pick the physical region just as be below the start marked.

Program Headers:
  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
  NOTE           0x0000000000000318 0x0000000000000000
0x0000000000000000
                 0x0000000000000b54 0x0000000000000000         0
  LOAD           0x00007fffff601000 0xffffffffff600000
0x0000000000000000
                 0x0000000000001000 0x0000000000001000  RWE    1000
  LOAD           0x00007fff81001000 0xffffffff81000000
0x0000000000000000
                 0x0000000001633000 0x0000000001633000  RWE    1000
  LOAD           0x0000490000001000 0xffffc90000000000
0x0000000000000000
                 0x00001fffffffffff 0x00001fffffffffff  RWE    1000
  LOAD           0x00007fffa0001000 0xffffffffa0000000
0x0000000000000000
                 0x000000005f000000 0x000000005f000000  RWE    1000

*******
  LOAD           0x0000080000002000 0xffff880000001000
0x0000000000000000
                 0x000000000009c000 0x000000000009c000  RWE    1000
*******

  LOAD           0x00006a0000001000 0xffffea0000000000
0x0000000000000000
                 0x0000000000003000 0x0000000000003000  RWE    1000

*******
  LOAD           0x0000080000101000 0xffff880000100000
0x0000000000000000
                 0x000000007fef0000 0x000000007fef0000  RWE    1000
*******

  LOAD           0x00006a0000005000 0xffffea0000004000
0x0000000000000000
                 0x0000000001ffc000 0x0000000001ffc000  RWE    1000

**********
  LOAD           0x0000080080001000 0xffff880080000000
0x0000000000000000
                 0x000000004fee0000 0x000000004fee0000  RWE    1000
***********


  LOAD           0x00006a0002001000 0xffffea0002000000
0x0000000000000000
                 0x00000000013fc000 0x00000000013fc000  RWE    1000

***********
  LOAD           0x0000080100001000 0xffff880100000000
0x0000000000000000
                 0x0000000130000000 0x0000000130000000  RWE    1000
************


  LOAD           0x00006a0004001000 0xffffea0004000000
0x0000000000000000
                 0x0000000004c00000 0x0000000004c00000  RWE    1000


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
