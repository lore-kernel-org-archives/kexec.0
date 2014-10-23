Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp10.uk.ibm.com ([195.75.94.106])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XhFfB-0000B9-Ha
 for kexec@lists.infradead.org; Thu, 23 Oct 2014 10:30:39 +0000
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Thu, 23 Oct 2014 11:30:13 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id F348A219005C
 for <kexec@lists.infradead.org>; Thu, 23 Oct 2014 11:29:45 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9NAU9aj61014214
 for <kexec@lists.infradead.org>; Thu, 23 Oct 2014 10:30:09 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9NAU9Gj018072
 for <kexec@lists.infradead.org>; Thu, 23 Oct 2014 04:30:09 -0600
Date: Thu, 23 Oct 2014 12:30:07 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH] makedumpfile: Enable --mem-usage for s390x
Message-ID: <20141023123007.282cb52e@holzheu>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701D580A9@BPXM01GP.gisp.nec.co.jp>
References: <1409541340-2719-1-git-send-email-bhe@redhat.com>
 <20140922170247.36774052@holzheu>
 <20140923024058.GC8697@dhcp-16-116.nay.redhat.com>
 <20140924171904.1db5ac90@holzheu>
 <20140925094412.GI8697@dhcp-16-116.nay.redhat.com>
 <20140926101057.14549a12@holzheu>
 <20140926085546.GA30346@dhcp-16-116.nay.redhat.com>
 <20140926133441.5e58303c@holzheu>
 <20140929090432.GA9989@dhcp-16-116.nay.redhat.com>
 <20140929151413.4e9bd1ab@holzheu>
 <20140930090201.GB9989@dhcp-16-116.nay.redhat.com>
 <20141001185953.66c6ae9d@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE9701D4D5E4@BPXM01GP.gisp.nec.co.jp>
 <20141010142310.4c488f6a@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE9701D4E4E4@BPXM01GP.gisp.nec.co.jp>
 <20141016143753.726f63c0@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE9701D580A9@BPXM01GP.gisp.nec.co.jp>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "bhe@redhat.com" <bhe@redhat.com>

Hello Atsushi,

On Thu, 23 Oct 2014 06:56:47 +0000
Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:

> >On Tue, 14 Oct 2014 07:19:13 +0000
> >Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:

[snip]

> I noticed that is_vmalloc_addr_x86_64() can't be used as is_phys_addr()
> due to the "kaslr issue". I fixed it in the common path as below, but
> --mem-usage still has the same issue since initial() will be invoked
> after get_kcore_dump_loads().
> 
>   http://lists.infradead.org/pipermail/kexec/2014-October/012743.html
> 
> I know it's so late, but I began to think the current implementation
> that invokes vaddr_to_paddr_XXX() before initial() is bad:
> 
> show_mem_usage()
>   + get_kcore_dump_loads()
>     + process_dump_load()
>       + vaddr_to_paddr_XXX()
>   + initial()
>   ...
> vaddr_to_paddr_XXX() does VtoP translation *properly*, so it needs
> several symbols. This design is OK since it's a general method.

So the current implementation that uses vaddr_to_paddr_xxx()
for --mem-usage *before* initial() is broken? Or does it currently
works only by chance?

> OTOH, we need a kludge which can be used under any situations and
> should use it for --mem-usage:
> 
>   VtoP_kludge_s390x(unsigned long vaddr) 
>   {
> 	/* s390 has 1:1 VtoP mapping that starts with zero. */
>   	return vaddr;
>   }
> 
> also x86_64's can be implemented like below:
> 
>   VtoP_kludge_x86_64(unsigned long vaddr) 
>   {
> 	/* if the address is direct mapped, it's easy to translate. */
> 	unsigned long paddr = vaddr - PAGE_OFFSET;
> 	return paddr;
>   }

What about using the kernel name __pa(vaddr)?

[snip]

> >--- a/elf_info.c
> >+++ b/elf_info.c
> >@@ -854,7 +854,7 @@ int get_kcore_dump_loads(void)
> >
> > 	for (i = 0; i < num_pt_loads; ++i) {
> > 		struct pt_load_segment *p = &pt_loads[i];
> >-		if (is_vmalloc_addr(p->virt_start))
> >+		if (!is_phys_addr(p->virt_start))
> 
> This part implicitly does VtoP translation.
> Actually it works for s390x but it's not suitable as a general code,
> so we should use VtoP_kludge(should be better name!) too.
> Then we can use is_iomem_phys_addr() also for other architecture.

So how exactly should the code look like for non s390x architectures?

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
