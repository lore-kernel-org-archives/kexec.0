Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Xiyhi-00067h-Qm
 for kexec@lists.infradead.org; Tue, 28 Oct 2014 04:48:23 +0000
Date: Tue, 28 Oct 2014 12:46:20 +0800
From: "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [PATCH] makedumpfile: Enable --mem-usage for s390x
Message-ID: <20141028044620.GA15783@dhcp-16-105.nay.redhat.com>
References: <20140929151413.4e9bd1ab@holzheu>
 <20140930090201.GB9989@dhcp-16-116.nay.redhat.com>
 <20141001185953.66c6ae9d@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE9701D4D5E4@BPXM01GP.gisp.nec.co.jp>
 <20141010142310.4c488f6a@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE9701D4E4E4@BPXM01GP.gisp.nec.co.jp>
 <20141016143753.726f63c0@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE9701D580A9@BPXM01GP.gisp.nec.co.jp>
 <20141027075707.GB1558@dhcp-16-105.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701D590F8@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701D590F8@BPXM01GP.gisp.nec.co.jp>
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

On 10/28/14 at 04:34am, Atsushi Kumagai wrote:
> >On 10/23/14 at 06:56am, Atsushi Kumagai wrote:

> >> I noticed that is_vmalloc_addr_x86_64() can't be used as is_phys_addr()
> >> due to the "kaslr issue". I fixed it in the common path as below, but
> >> --mem-usage still has the same issue since initial() will be invoked
> >> after get_kcore_dump_loads().
> >>
> >>   http://lists.infradead.org/pipermail/kexec/2014-October/012743.html
> >>
> >> I know it's so late, but I began to think the current implementation
> >> that invokes vaddr_to_paddr_XXX() before initial() is bad:
> >>
> >> show_mem_usage()
> >>   + get_kcore_dump_loads()
> >>     + process_dump_load()
> >>       + vaddr_to_paddr_XXX()
> >>   + initial()
> >
> >This is a bug. Seems that get_kcore_dump_loads() has to be called in
> >initial(). Since dumped vmcore need contains kernel text segment.
> >Without setting correct value for MODULES_VADDR, it will be equal to
> >__START_KERNEL_map, then calling is_vmalloc_addr() will filter kernel
> >text mapping segment too.
> >
> >Now it seems only one way to solve this, that is moving
> >get_kcore_dump_loads() into initial() just after
> >get_value_for_old_linux() is called.
> 
> I agree, I'll do it, thanks.

Actually hpa haven't merged my patchset. Seems he doesn't like current
kaslr design. I am not sure if we have gone too far to adjust
makedumpfile code to support kaslr. I'll ask him for comments or plans.

Thanks
Baoquan

> 
> 
> Atsushi Kumagai
> 
> >>   ...
> >>
> >> vaddr_to_paddr_XXX() does VtoP translation *properly*, so it needs
> >> several symbols. This design is OK since it's a general method.
> >> OTOH, we need a kludge which can be used under any situations and
> >> should use it for --mem-usage:
> >>
> >>   VtoP_kludge_s390x(unsigned long vaddr)
> >>   {
> >> 	/* s390 has 1:1 VtoP mapping that starts with zero. */
> >>   	return vaddr;
> >>   }
> >>
> >> also x86_64's can be implemented like below:
> >>
> >>   VtoP_kludge_x86_64(unsigned long vaddr)
> >>   {
> >> 	/* if the address is direct mapped, it's easy to translate. */
> >> 	unsigned long paddr = vaddr - PAGE_OFFSET;
> >> 	return paddr;
> >>   }
> >>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
