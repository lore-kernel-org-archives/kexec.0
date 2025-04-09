Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F2BC369B7
	for <kexec@archiver.kernel.org>; Mon, 14 Apr 2025 08:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W+rzVntm5p2Upg2kRDHuwQQd262xO4O+7g2Yr15egZc=; b=Ag9llUHbHawYN8QfVLacwjWKum
	20kK9nOnuRDmAJqPEQ6E5pa+ydqQPyDRDRm8bIivs17V4eTl8ql7m2PbX/9BR1QEWuN4VV0vdnVLf
	ctrQi6dXyDsL4IgYa7A31rIVp/Ii6HZPCynrWIACn2P6VOXKsujw9RS08K6F2KQoxPReYUT8PVeYr
	P+5SRIxIaItNoA9c42JmHtx307mNXjL68eBq6BjAfd1SL5H1+Ma4hYRv3jl79Oshms9qq2EeTmOyZ
	C7JV1a2owFelOjUU1pAelcZJj+1oA5dREDMRPdqyQChh7QC8tT7UlKNQ5mvNDbk2RLmweAxQ4r9i5
	oy8hFGnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4FJV-000000017bd-2uW6;
	Mon, 14 Apr 2025 08:37:09 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2Y9T-00000007re1-17ys;
	Wed, 09 Apr 2025 16:19:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 668755C0E69;
	Wed,  9 Apr 2025 16:17:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6114CC4CEE7;
	Wed,  9 Apr 2025 16:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744215586;
	bh=O547vvi8wN4fNcefZC+j8pm7sBawXkTtl7ULJh5r69Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VztxvMqXxrpm841YCPlRs5HxRWtyQCzteRRbsExjaVh5HQZx45QxpYyiLBSJuv3X2
	 MN7vgPzgclauypOQrUuLMro0cb2A0r82+RdvOdFbdWLfEEJnlIKYXhzyYcrWqjWDQY
	 Q2bNXiFlR1BufsnZpfyjBbXsf215Q3IWHCFYnUYB2UaCy9B+xsxoGFnRP/J8guSrrR
	 tE+UzMvqzhuoQsiyE/Fb8/shQw2OD0K6GR+ygi9Kvnxt8ywUgCPvZUdDJ+rdXobs4P
	 AmIZmTueujQ0kDezDalKcjSW/fDLL+xKB1kEOBg1cCPtZwRGJQ0wI8e45idxGkET1w
	 JGcNybozD2e9A==
Date: Wed, 9 Apr 2025 19:19:30 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pratyush Yadav <ptyadav@amazon.de>,
	Changyuan Lyu <changyuanl@google.com>, linux-kernel@vger.kernel.org,
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
	linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v5 09/16] kexec: enable KHO support for memory
 preservation
Message-ID: <Z_aeEn7hKqGOG3Cf@kernel.org>
References: <Z-_kSXrHWU5Bf3sV@kernel.org>
 <20250404143031.GB1336818@nvidia.com>
 <Z_KnovvW7F2ZyzhX@kernel.org>
 <20250407141626.GB1557073@nvidia.com>
 <Z_P92UCbNCV0TbiA@kernel.org>
 <20250407170305.GI1557073@nvidia.com>
 <Z_Y4k4rDO-BbMjqs@kernel.org>
 <20250409125630.GI1778492@nvidia.com>
 <Z_Z8-BLWMkiWpaDY@kernel.org>
 <20250409153714.GK1778492@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409153714.GK1778492@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250409_091947_409975_30238373 
X-CRM114-Status: GOOD (  21.06  )
X-Mailman-Approved-At: Mon, 14 Apr 2025 01:36:58 -0700
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

On Wed, Apr 09, 2025 at 12:37:14PM -0300, Jason Gunthorpe wrote:
> On Wed, Apr 09, 2025 at 04:58:16PM +0300, Mike Rapoport wrote:
> > >
> > > I think we still don't really know what will be needed, so I'd stick
> > > with folio only as that allows building the memfd and a potential slab
> > > preservation system.
> > 
> > void * seems to me much more reasonable than folio one as the starting
> > point because it allows preserving folios with the right order but it's not
> > limited to it. 
> 
> It would just call kho_preserve_folio() under the covers though.

How that will work for memblock and 1G pages?
 
> > I don't mind having kho_preserve_folio() from day 1 and even stretching the
> > use case we have right now to use it to preserve FDT memory.
> > 
> > But kho_preserve_folio() does not make sense for reserve_mem and it won't
> > make sense for vmalloc.
> 
> It does for vmalloc too, just stop thinking about it as a
> folio-for-pagecache and instead as an arbitary order handle to buddy
> allocator memory that will someday be changed to a memdesc :|

But we have memdesc today, it's struct page. It will be shrinked and maybe
renamed, it will contain a pointer rather than data, but that's what basic
memdesc is.
And when the data structure that memdesc points to will be allocated
separately folios won't make sense for order-0 allocations.
 
> > The weird games slab does with casting back and forth to folio also seem to
> > me like transitional and there won't be that folios in slab later.
> 
> Yes transitional, but we are at the transitional point and KHO should
> fit in.
> 
> The lowest allocator primitive returns folios, which can represent any
> order, and the caller casts to their own memdesc.

The lowest allocation primitive returns pages. 

struct folio *__folio_alloc_noprof(gfp_t gfp, unsigned int order, int preferred_nid,
		nodemask_t *nodemask)
{
	struct page *page = __alloc_pages_noprof(gfp | __GFP_COMP, order,
					preferred_nid, nodemask);
	return page_rmappable_folio(page);
}
EXPORT_SYMBOL(__folio_alloc_noprof);

And page_rmappable_folio() clues about folio-for-pagecache very clearly.

And I don't think folio will be a lowest primitive buddy returns anytime
soon if ever.
 
> Jason
> 

-- 
Sincerely yours,
Mike.

