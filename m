Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE42C53219
	for <kexec@archiver.kernel.org>; Tue, 28 Jul 2026 13:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F7E60EEGx3HhYQLCew9dec70QQpFr1JD3ItgZk/3IBg=; b=1sRBMBU2M2uImdq7Trh2N3xmQL
	64kL3PQopunZho4zdELZoJ9qMAI5oGYiaFbv0naZcLDwM/ThYKX2DunT2OKlGQmiB8iBLJqw5dccp
	Pl3tGHvG8T5ag5VDOg6zXAlKBIWtGUtPTv/R7enICNAlZsVOinjN+5X+HNBsNhOaO/SUciaFNFpQY
	1fy9zzNSqxQQlqAYwEFpj3uU5X7GfdEnLJcgsjCoJV2U8SDuUYsPrRfKUhQAGzu5QKixABQKYjO5R
	AmYzWJhrXsN60Gfxhy9awtXO4h9QVZHuCbmj9DSABEYQZVsWtahcSsmfrE1CeLUpdBOVlgjUbRlPV
	nLzAMKqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wohyI-00000005Ma2-16lp;
	Tue, 28 Jul 2026 13:35:50 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wohyH-00000005MZe-3iqF
	for kexec@lists.infradead.org;
	Tue, 28 Jul 2026 13:35:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4579540DE8;
	Tue, 28 Jul 2026 13:35:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6F61F000E9;
	Tue, 28 Jul 2026 13:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785245749;
	bh=F7E60EEGx3HhYQLCew9dec70QQpFr1JD3ItgZk/3IBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hJ6ZyGrXFohV282rb4DcBTZtLaXEm4DG4EzBSaAk21cm4cHuYoe24V2bP2A3XjLTX
	 7/D8dj15R5W/TNZgNi8iJNfMD6iu4ysPmFfd67MHL87sKSj/quy+1zpDftRPgID1md
	 W1Dg46CjtdpalY9SmavmC1shWHb2XACiP+0fjTLovQV4x9EzRnu4pwlZkM0prax1iI
	 IYZfhTDMOXUzqcjDzb79D/1mBLqK9/xMKVSgLT4zm79An4+G6SLphQoJHGp/ayHn7Y
	 NHm/DiPdusfbad3D4k8lq9K3yZREeduP64s/aoQP0iA/h7DLaYue/b4dvGjVmFeSuv
	 erXV/LxzbgXtA==
Date: Tue, 28 Jul 2026 16:35:41 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Miu <jasonmiu@google.com>,
	Jork Loeser <jloeser@linux.microsoft.com>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/21] kho: make boot time huge page allocation work
 nicely with KHO
Message-ID: <amiwLSEi8cczamP1@kernel.org>
References: <20260725172133.4018491-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260725172133.4018491-1-pratyush@kernel.org>
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

On Sat, Jul 25, 2026 at 07:21:00PM +0200, Pratyush Yadav wrote:
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> 
> Hi,
> 
> Gigantic huge page allocation is somewhat broken currently with KHO.
> 
> First, they break scratch size accounting. Since they are allocated
> using the memblock alloc APIs, they count towards RSRV_KERN, and this
> scratch size when using scratch_scale. This means if huge pages take a
> large enough chunk of system memory scratch size will blow up and fail
> to allocate.
> 
> Second, scratch can not contain preserved memory, and if hugepages are
> allocated from scratch, they will fail to be preserved with the upcoming
> hugetlb preservation series [0].
> 
> Fix this by introducing the concept of extended scratch areas. They are
> areas that the kernel discovers on boot by walking the radix tree and
> finding free memory ranges. See patch 10 for more details.
> 
> Muchun Song (1):
>   mm/mm_init: simplify deferred_free_pages() migratetype init
> 
> Pratyush Yadav (Google) (20):
>   kho: generalize radix tree APIs
>   kho: make radix max key width more obvious
>   kho: disallow wide keys in radix tree
>   kho: return virtual address of mem_map from kho_get_mem_map()
>   kho: store incoming radix tree in kho_in
>   kho: move all memory retrieval logic to kho_mem_retrieve()
>   kho: add a struct for radix callbacks
>   kho: add callback for table pages
>   kho: add data argument to radix walk callback
>   kho: allow early-boot usage of the KHO radix tree
>   kho: allow destroying KHO radix tree
>   kho: add kho_radix_init_tree()
>   kho: expose kho_scratch_overlap() to kexec_handover.h
>   kho: initialize kho_scratch pointer earlier in boot
>   kho: initialize preserved memory map radix tree earlier
>   mm/mm_init: don't rely on memblock to get KHO scratch migratetype
>   kho: extend scratch
>   memblock: make HugeTLB bootmem allocation work with KHO
>   memblock: add memblock_reserved_hugetlb_size()
>   kho: exclude hugetlb memory from scratch size calculation

I added it to the liveupdate tree.

Please take a look at Sashiko comments, we might need v5 if it has valid
(not pre-existing) points.

-- 
Sincerely yours,
Mike.

