Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E81FC369B5
	for <kexec@archiver.kernel.org>; Mon, 14 Apr 2025 08:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TS1J/iGjpOnhfesj1YKRHzCDJZQiACcT4LkCJhVJGx0=; b=odHeSRkiiH3VMGIhsVoAnwGNFP
	DgqZUYcQ/XN9jKZ4CfDboNAO212vGXC+W0QEEDeiyks3BM2T6PpybwSPb/p4h49CjxxMlTooxayhJ
	XhlwHHIOxofkvG/p0OHfbn4ns8YHumd52Ud5DYCcelFNCt2npv3co9zDw/ykkOn0hicALbpgrTuyf
	97cxqSLku9ZUpHUhI+lWHylcHmVKDBwkpLBqKHCwRSEV6KLTMnRNAUGKEeSTtFgQyCrjG91p6Cr7q
	T5vdrdU/khxvvc0n4LUm5RONNSD+Drf+DniJteVz1NrmkKk22fDS339qOVlH6kbFX5Si1fwTQ9Y3J
	morBaa+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4FJS-000000017WN-3Gv9;
	Mon, 14 Apr 2025 08:37:06 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2RON-00000006fER-2Wul;
	Wed, 09 Apr 2025 09:06:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 41B9D43A63;
	Wed,  9 Apr 2025 09:06:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20181C4CEE3;
	Wed,  9 Apr 2025 09:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744189602;
	bh=/s+U51p2rme6ttKunG01nE4+T3pq5eYIYautG/ah3Wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eerjUQlvNJF+OcsvIsqmEbAp/QAZ/fvQAZPtZABd4PBsB7L/b4Q5V00nkAKW7iTGB
	 fOWeKV/HJ/ib1NS32lxrfK674W4vSwxOS/yrVTY0c7xJyhbfGDcT9JWQU5S0ZYKolL
	 bIKUumb/XfD+cSCkjS6jADB/RYMB7aQ2g7eLdflW7X+exTmDyUGTqcW+pVSPt4uoGZ
	 oTqY7MD0cLXyIw8SnWTcPccndUqN9w/kWekQURRgNXJsL+uDtiwyA58zBUMHEEnuxs
	 chk5n2/7cxnMmUCrsFmejaBdPXgvCnJLEGYHXd5nkJcUyqeHVzitwPYKYPg2Ps+4hN
	 M2oTs57z8vEAg==
Date: Wed, 9 Apr 2025 12:06:27 +0300
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
Message-ID: <Z_Y4k4rDO-BbMjqs@kernel.org>
References: <Z-6UA3C1TPeH_kGL@kernel.org>
 <20250403142438.GF342109@nvidia.com>
 <Z--sUYCvP3Q8nT8e@kernel.org>
 <20250404124729.GH342109@nvidia.com>
 <Z-_kSXrHWU5Bf3sV@kernel.org>
 <20250404143031.GB1336818@nvidia.com>
 <Z_KnovvW7F2ZyzhX@kernel.org>
 <20250407141626.GB1557073@nvidia.com>
 <Z_P92UCbNCV0TbiA@kernel.org>
 <20250407170305.GI1557073@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407170305.GI1557073@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250409_020643_994319_D540697A 
X-CRM114-Status: GOOD (  28.84  )
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

On Mon, Apr 07, 2025 at 02:03:05PM -0300, Jason Gunthorpe wrote:
> On Mon, Apr 07, 2025 at 07:31:21PM +0300, Mike Rapoport wrote:
> >
> > Ok, let's stick with memdesc then. Put aside the name it looks like we do
> > agree that KHO needs to provide a way to preserve memory allocated from
> > buddy along with some of the metadata describing that memory, like order
> > for multi-order allocations.
> 
> +1
> 
> > The issue I see with bitmaps is that there's nothing except the order that
> > we can save. And if sometime later we'd have to recreate memdesc for that
> > memory, that would mean allocating a correct data structure, i.e. struct
> > folio, struct slab, struct vmalloc maybe.
> 
> Yes. The caller would have to take care of this using a caller
> specific serialization of any memdesc data. Like slab would have to
> presumably record the object size and the object allocation bitmap.
> 
> > I'm not sure we are going to preserve slabs at least at the foreseeable
> > future, but vmalloc seems like something that we'd have to address.
> 
> And I suspect vmalloc doesn't need to preserve any memdesc information?
> It can all be recreated

vmalloc does not have anything in memdesc now, just plain order-0 pages
from alloc_pages variants.

Now we've settled with terminology, and given that currently memdesc ==
struct page, I think we need kho_preserve_folio(struct *folio) for actual
struct folios and, apparently other high order allocations, and
kho_preserve_pages(struct page *, int nr) for memblock, vmalloc and
alloc_pages_exact.

On the restore path kho_restore_folio() will recreate multi-order thingy by
doing parts of what prep_new_page() does. And kho_restore_pages() will
recreate order-0 pages as if they were allocated from buddy.

If the caller needs more in its memdesc, it is responsible to fill in the
missing bits.
 
> > > Also the bitmap scanning to optimize the memblock reserve isn't
> > > implemented for xarray.. I don't think this is representative..
> > 
> > I believe that even with optimization of bitmap scanning maple tree would
> > perform much better when the memory is not fragmented. 
> 
> Hard to guess, bitmap scanning is not free, especially if there are
> lots of zeros, but memory allocating maple tree nodes and locking them
> is not free either so who knows where things cross over..
> 
> > And when it is fragmented both will need to call memblock_reserve()
> > similar number of times and there won't be real difference. Of
> > course maple tree will consume much more memory in the worst case.
> 
> Yes.
> 
> bitmaps are bounded like the comment says, 512K for 16G of memory with
> arbitary order 0 fragmentation.
> 
> Assuming absolute worst case fragmentation maple tree (@24 bytes per
> range, alternating allocated/freed pattern) would require around
> 50M. Then almost doubled since we have the maple tree and then the
> serialized copy.
> 
> 100Mb vs 512k - I will pick the 512K :)

Nah, memory is cheap nowadays :)

Ok, let's start with bitmaps and then see what are the actual bottlenecks
we have to optimize.
 
> Jason

-- 
Sincerely yours,
Mike.

