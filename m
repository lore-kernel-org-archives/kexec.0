Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cZEW1-0001mk-0I
 for kexec@lists.infradead.org; Thu, 02 Feb 2017 10:21:22 +0000
Received: by mail-pf0-f180.google.com with SMTP id 189so4419163pfu.3
 for <kexec@lists.infradead.org>; Thu, 02 Feb 2017 02:21:00 -0800 (PST)
Date: Thu, 2 Feb 2017 19:21:32 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v31 04/12] arm64: mm: allow for unmapping part of kernel
 mapping
Message-ID: <20170202102131.GD13549@linaro.org>
References: <20170201124218.5823-1-takahiro.akashi@linaro.org>
 <20170201124630.6016-3-takahiro.akashi@linaro.org>
 <20170201160354.GF4756@leverpostej>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170201160354.GF4756@leverpostej>
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
To: Mark Rutland <mark.rutland@arm.com>
Cc: geoff@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Wed, Feb 01, 2017 at 04:03:54PM +0000, Mark Rutland wrote:
> Hi,
> 
> On Wed, Feb 01, 2017 at 09:46:23PM +0900, AKASHI Takahiro wrote:
> > A new function, remove_pgd_mapping(), is added.
> > It allows us to unmap a specific portion of kernel mapping later as far as
> > the mapping is made using create_pgd_mapping() and unless we try to free
> > a sub-set of memory range within a section mapping.
> 
> I'm not keen on adding more page table modification code. It was painful
> enough to ensure that those worked in all configurations.
> 
> Why can't we reuse create_pgd_mapping()? If we pass page_mappings_only,
> and use an invalid prot (i.e. 0), what is the problem?

As I did in v30?
(though my implementation in v30 should be improved.)

> I can see that we wouldn't free/reallocate the pud or pmd entries, but
> the "wasted" memory should be small. If anything, I'd argue that it's
> preferable to keep that around so that we don't have to allocate memory
> when we need to map the crashkernel region.
> 
> Is there another problem I'm missing?

If we don't need to free unused page tables, that would make things
much simple. There are still some minor problems on the merge, but
we can sort it out.

Thanks,
-Takahiro AKASHI

> > +static bool pgtable_is_cleared(void *pgtable)
> > +{
> > +	unsigned long *desc, *end;
> > +
> > +	for (desc = pgtable, end = (unsigned long *)(pgtable + PAGE_SIZE);
> > +	     desc < end; desc++)
> > +		if (*desc)
> > +			return false;
> > +
> > +	return true;
> > +}
> 
> If nothing else, we should be using the normal accessors for this, e.g.
> {pte,pmd,pud}_none().
> 
> As above, I'd very much like to reuse our existing page table routines
> if we can.
> 
> Thanks,
> Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
