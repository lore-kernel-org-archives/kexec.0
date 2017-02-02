Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cZHy2-0000wp-3Q
 for kexec@lists.infradead.org; Thu, 02 Feb 2017 14:02:32 +0000
Received: by mail-pg0-f52.google.com with SMTP id 3so6075648pgj.3
 for <kexec@lists.infradead.org>; Thu, 02 Feb 2017 06:02:09 -0800 (PST)
Date: Thu, 2 Feb 2017 23:01:03 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v31 04/12] arm64: mm: allow for unmapping part of kernel
 mapping
Message-ID: <20170202140102.GA22666@fireball>
References: <20170201124218.5823-1-takahiro.akashi@linaro.org>
 <20170201124630.6016-3-takahiro.akashi@linaro.org>
 <20170201160354.GF4756@leverpostej>
 <20170202102131.GD13549@linaro.org>
 <20170202114437.GH31394@leverpostej>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170202114437.GH31394@leverpostej>
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

On Thu, Feb 02, 2017 at 11:44:38AM +0000, Mark Rutland wrote:
> On Thu, Feb 02, 2017 at 07:21:32PM +0900, AKASHI Takahiro wrote:
> > On Wed, Feb 01, 2017 at 04:03:54PM +0000, Mark Rutland wrote:
> > > Hi,
> > > 
> > > On Wed, Feb 01, 2017 at 09:46:23PM +0900, AKASHI Takahiro wrote:
> > > > A new function, remove_pgd_mapping(), is added.
> > > > It allows us to unmap a specific portion of kernel mapping later as far as
> > > > the mapping is made using create_pgd_mapping() and unless we try to free
> > > > a sub-set of memory range within a section mapping.
> > > 
> > > I'm not keen on adding more page table modification code. It was painful
> > > enough to ensure that those worked in all configurations.
> > > 
> > > Why can't we reuse create_pgd_mapping()? If we pass page_mappings_only,
> > > and use an invalid prot (i.e. 0), what is the problem?
> > 
> > As I did in v30?
> > (though my implementation in v30 should be improved.)
> 
> Something like that. I wasn't entirely sure why we needed to change
> those functions so much, so I'm clearly missing something there. I'll go
> have another look.

I would be much easier if you see my new code.

> > > I can see that we wouldn't free/reallocate the pud or pmd entries, but
> > > the "wasted" memory should be small. If anything, I'd argue that it's
> > > preferable to keep that around so that we don't have to allocate memory
> > > when we need to map the crashkernel region.
> > > 
> > > Is there another problem I'm missing?
> > 
> > If we don't need to free unused page tables, that would make things
> > much simple. There are still some minor problems on the merge, but
> > we can sort it out.
> 
> I'm not sure I follow what you mean by 'on merge' here. Could you
> elaborate?

What I had in mind is some changes needed to handle "__prot(0)" properly
in alloc_init_pxx(). For example, p[mu]d_set_huge() doesn't make
a "zeroed" entry.

-Takahiro AKASHI

> Thanks,
> Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
