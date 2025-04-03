Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA8CFC369A7
	for <kexec@archiver.kernel.org>; Fri,  4 Apr 2025 13:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zez+6p8Y3I5aFWhI6/jit+0uu3QYEFLgq6rmajm/pbc=; b=NSPYBanefhAOTqAchJuKKWJiY5
	gqlI5YGX21CmULJVbX+3XTD2TJMYVxxRo3v9mr2vacw58V31wZwd+rzncS3fYFIT6TXbrQQfWX/P1
	q5OV34cMvwOrMFmUElNTTuqxK4HTqkme04J3EMaNy6aA4H1bE/hnnGlLNCYWhpk7ckvCQatQUG/MK
	8mPFvwePZYOwbzE0xZsNoAXiOPXqfwQPO7Bull8SYepxQ9iMmpHvo7FtjeR8U8rnTx0xraDA3qVY2
	WHiGtUmVifeRRcqbk8/J/I7AMJDiBr9q3kFLHUGxO/FfkLbONe1w/HSQ3/1UgWVwRljx4532RzGb6
	UAmelysg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0gl6-0000000BlEb-192T;
	Fri, 04 Apr 2025 13:06:56 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0L4h-00000008yvI-25dO;
	Thu, 03 Apr 2025 13:57:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 003CA4395F;
	Thu,  3 Apr 2025 13:57:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A24EC4CEE3;
	Thu,  3 Apr 2025 13:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743688661;
	bh=5SR2KTBI1kKtfOBINvsox0Z0ryfiIm93Ekm8MRv/a4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iW7Kcl6McmBEbJ1JPZ4u0Huxc2f6LpTnxB8SXB6QM6RbBFXxP9bN9E8qyknVSdeu+
	 l/b+SAQ0QWM3fR8hQqvYA7ZOXApBXeYHLHS2dOtEI4U4eNVuZ996rcgf9L1vOMk1VK
	 fsR+piAc8w0Tw7dC/yfcWpuGp/3Zm0/Hg6A4cnGFfj20+RRAL0D7bzGlvX7pR+TyEM
	 MNWnWibgibRxnmAdvGDG7Qxe1hwAugVpYoRsDOYU8Dz9TOIZ3hKlDJrJ32IqaHfWrO
	 0gY5wz+zFvE4o6h1f3Wor+aFDgX4QJbAEqle0OkXvoDBz/9rl4ykSomefNEMfNRYWa
	 D3h05S20MooXA==
Date: Thu, 3 Apr 2025 16:57:25 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <ptyadav@amazon.de>
Cc: Changyuan Lyu <changyuanl@google.com>, linux-kernel@vger.kernel.org,
	graf@amazon.com, akpm@linux-foundation.org, luto@kernel.org,
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com,
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com,
	dave.hansen@linux.intel.com, dwmw2@infradead.org,
	ebiederm@xmission.com, mingo@redhat.com, jgowans@amazon.com,
	corbet@lwn.net, krzk@kernel.org, mark.rutland@arm.com,
	pbonzini@redhat.com, pasha.tatashin@soleen.com, hpa@zytor.com,
	peterz@infradead.org, robh+dt@kernel.org, robh@kernel.org,
	saravanak@google.com, skinsburskii@linux.microsoft.com,
	rostedt@goodmis.org, tglx@linutronix.de, thomas.lendacky@amd.com,
	usama.arif@bytedance.com, will@kernel.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, x86@kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v5 09/16] kexec: enable KHO support for memory
 preservation
Message-ID: <Z-6TxZWEWbKSCqfh@kernel.org>
References: <20250320015551.2157511-1-changyuanl@google.com>
 <20250320015551.2157511-10-changyuanl@google.com>
 <mafs05xjmqsqc.fsf@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs05xjmqsqc.fsf@amazon.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250403_065743_618171_050DE7EA 
X-CRM114-Status: GOOD (  31.69  )
X-Mailman-Approved-At: Fri, 04 Apr 2025 06:06:49 -0700
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed, Apr 02, 2025 at 07:16:27PM +0000, Pratyush Yadav wrote:
> Hi Changyuan,
> 
> On Wed, Mar 19 2025, Changyuan Lyu wrote:
> 
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> >
> > Introduce APIs allowing KHO users to preserve memory across kexec and
> > get access to that memory after boot of the kexeced kernel
> >
> > kho_preserve_folio() - record a folio to be preserved over kexec
> > kho_restore_folio() - recreates the folio from the preserved memory
> > kho_preserve_phys() - record physically contiguous range to be
> > preserved over kexec.
> > kho_restore_phys() - recreates order-0 pages corresponding to the
> > preserved physical range
> >
> > The memory preservations are tracked by two levels of xarrays to manage
> > chunks of per-order 512 byte bitmaps. For instance the entire 1G order
> > of a 1TB x86 system would fit inside a single 512 byte bitmap. For
> > order 0 allocations each bitmap will cover 16M of address space. Thus,
> > for 16G of memory at most 512K of bitmap memory will be needed for order 0.
> >
> > At serialization time all bitmaps are recorded in a linked list of pages
> > for the next kernel to process and the physical address of the list is
> > recorded in KHO FDT.
> >
> > The next kernel then processes that list, reserves the memory ranges and
> > later, when a user requests a folio or a physical range, KHO restores
> > corresponding memory map entries.
> >
> > Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Co-developed-by: Changyuan Lyu <changyuanl@google.com>
> > Signed-off-by: Changyuan Lyu <changyuanl@google.com>
> > ---
> >  include/linux/kexec_handover.h |  38 +++
> >  kernel/kexec_handover.c        | 486 ++++++++++++++++++++++++++++++++-
> >  2 files changed, 522 insertions(+), 2 deletions(-)
> [...]
> > +int kho_preserve_phys(phys_addr_t phys, size_t size)
> > +{
> > +	unsigned long pfn = PHYS_PFN(phys), end_pfn = PHYS_PFN(phys + size);
> > +	unsigned int order = ilog2(end_pfn - pfn);
> 
> This caught my eye when playing around with the code. It does not put
> any limit on the order, so it can exceed NR_PAGE_ORDERS. Also, when

I don't see a problem with this

> initializing the page after KHO, we pass the order directly to
> prep_compound_page() without sanity checking it. The next kernel might
> not support all the orders the current one supports. Perhaps something
> to fix?

And this needs to be fixed and we should refuse to create folios larger
than MAX_ORDER.
 
> > +	unsigned long failed_pfn;
> > +	int err = 0;
> > +
> > +	if (!kho_enable)
> > +		return -EOPNOTSUPP;
> > +
> > +	down_read(&kho_out.tree_lock);
> > +	if (kho_out.fdt) {
> > +		err = -EBUSY;
> > +		goto unlock;
> > +	}
> > +
> > +	for (; pfn < end_pfn;
> > +	     pfn += (1 << order), order = ilog2(end_pfn - pfn)) {
> > +		err = __kho_preserve(&kho_mem_track, pfn, order);
> > +		if (err) {
> > +			failed_pfn = pfn;
> > +			break;
> > +		}
> > +	}
> [...
> > +struct folio *kho_restore_folio(phys_addr_t phys)
> > +{
> > +	struct page *page = pfn_to_online_page(PHYS_PFN(phys));
> > +	unsigned long order = page->private;
> > +
> > +	if (!page)
> > +		return NULL;
> > +
> > +	order = page->private;
> > +	if (order)
> > +		prep_compound_page(page, order);
> > +	else
> > +		kho_restore_page(page);
> > +
> > +	return page_folio(page);
> > +}
> [...]
> 
> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.

