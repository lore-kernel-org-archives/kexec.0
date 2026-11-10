Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E6B606A336
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 10:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lL3VAGnv;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TFk/Y+ji
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=FlTOvt8xOuSZHY/ZhFJxT3wExaMHYGHsA+ZOjDuv1Xg=; b=lL3VAGnvGxqedVwnbwEj4kOB+b
	pJpLEa6zlOnMkooorKJOoVnxEi+BR+ZS6Dh+xdaTd9nLbsK9uhvtOOxJMxePEjOpHsoe1VLodoUWA
	Ls9Mwe2tDzz0VZO9PkKck6wY1XidBnyGfP7IFSDZac2lyRh4+uZnbexpyMv2aFyAQTQlO4U6KqtKd
	zDjn71e6AH/wcOjm0Zs0fqD4jLVB7hPRSj4sloWRzfLWUlaXQnjfkLyPtkeUSe2p77Wvsp+LTTXx1
	GNrqwg2Kwai9xRJpIVzjqTfnK1xt4UNFZ0gevrR1nvIX5ttkFlpL76ESsQnpobB2XvIgvFpJsJ9iX
	Aed4J9yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQj8I-00000003Sqy-2IUf;
	Tue, 10 Nov 2026 10:31:18 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQj8H-00000003Sqq-1VEY
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 10:31:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 22CE1410D0;
	Tue, 10 Nov 2026 10:31:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C371A1F0089F;
	Tue, 10 Nov 2026 10:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794306677;
	bh=FlTOvt8xOuSZHY/ZhFJxT3wExaMHYGHsA+ZOjDuv1Xg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TFk/Y+jiK+EeQW5DRQUIlqyMDJ1m7JtpGMtzUWzaNuBXN8NGzSIQYRjDtEsZSS/Lq
	 nTl+qHoUewD+1ZWM6II/Z3cVkeeffvj6N19cFlEpgV0ZerIjvKcQsq7ti5MBhDtgh+
	 Z6ABlVaHvb0obwpM9gRl506tiidEpK9JNBdgYLo2DPwy3DEAR49tfrZAexflUvATq4
	 PHnjleqWVM/ZNUU2TiM+ak+96r+PD/jhhY+YE3XzdHqSnJ2Chwpnp/PtFjfKvZIU1l
	 KGxHtdDHpHj5UenNAe4G4E+rwKnmRmHw6zeYBP8Izh4offkWLE5yQ9MCwbLrz7GQ1C
	 V+XjNaE47uQCw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.ams.internal (Postfix) with ESMTP id 84C96198003A;
	Tue, 10 Nov 2026 05:31:08 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 10 Nov 2026 05:31:13 -0500
X-ME-Sender: <xms:a_LyalRqEEi22Zqq6xXTNfIUy1eL86wOL44elLImVT1Lsz4I5o4NDQ>
    <xme:a_LyaofLRkKgdVDCIpLMt-x0w2QBiy6WJ3SG2qd3kB3mLSD0b_evF3p9ohLL5ZLV_
    OfegCXLJf86bDoZm-OFgj4KgF0XOHoCUx3AT3GPPCQ0H9EYcGT2_YSL>
X-ME-Received: <xmr:a_LyahzS7EBQguTo6tQOf3vfPqVyehOAK23g_Ana5o6vWhs_lDY5Dgn7Ycs>
X-ME-Proxy-Cause: dmFkZTEG22a+fWVd70W49sFkRLfWvSfLcWkkA8IdPKW1pytV604LiaaxMHr+3VX6gcn2ih
    GiUPahwkcrJH43OV7arrk1kjGoupNgLdUGWA4rlKrCZdhAxycDsbiIvNnshqWYHI+xLDe7
    dxnOUcGrxdxai4noAKbPqcoiuqTq9Tod3cSSi9wDUWiqFbOM1ID69QdDUWEKVjGm82rvAt
    JR0UnN68vbOUf5D+VOrJZpgRA9Wh8QJ0moenK7uAy/B7MIYsD+VIAyYz7XTWxdZEo9/pA+
    5BRy43Xu6FxuylSNGzBoqk8fdRU/C/TaThdgv/qpGOTUROZq+kPfrdsgaZtu/HQc2YspNq
    EKJ62rkXCupFiccIn7l53OEU9i211HD6OS/YfEOm47OcP2NA61JeSas/jWclFEP3D3DEeE
    efYfWjXpUN+S8GDN/VhSqFSJWW4VuwFgbEpc9uHxiC67VKgTZ+ME4p8H3qec7YdgCKwFWG
    eHP2eUftj4HU/7zaw8vRb54j2/i2x5gwz4FdcwObCwUq/eJ09xn8D1Ip1B+J5u2vN/slUH
    LNLhiJthRs9RHC4IILLJbsnRZhvAVfABd+0fCgi6qFZyoN50GvPmjgxDdz8NgWpk/R2ks4
    VnE/UIouYNnuFUF5IN5hePej0uFfDKFZ4yO3cvK29zLUrxuLXll19+3AYkvQ
X-ME-Proxy: <xmx:bPLyahG7ogfO690v1-QjAH6E3xLHXpH-QYT5DmlN8Q25wNoyJG514g>
    <xmx:bPLyat5zOTNLQyqaeyO7kYwF95OY41Lo4707nSIzHk49ns3u-pP4jw>
    <xmx:bPLyagEiQCloo7AHvZ5xh3p-bgvb-j_epsB5qcDMBfskiHWpaQ2BcA>
    <xmx:bPLyalA3FAEjqpSRI-xagrKLiK1OOBO02b09RiOIh-Zgwo5Bl40rNQ>
    <xmx:bPLyahBlf8mf5Dse7Df3PSCo9B8OPUYJcjcL_9jT9ga7mVAS6Bz3KGF0>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 05:31:06 -0500 (EST)
Date: Tue, 10 Nov 2026 10:31:05 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, baoquan.he@linux.dev, 
	rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, 
	ruirui.yang@linux.dev, corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, 
	muchun.song@linux.dev, osalvador@suse.de, david@kernel.org, jbohac@suse.cz, 
	sourabhjain@linux.ibm.com, ruanjinjie@huawei.com, leitao@debian.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev, 
	zaslonko@linux.ibm.com, brads@mainlining.org, kernel-team@meta.com
Subject: Re: [PATCH v2] mm/hugetlb: allow crashkernel to reuse hugetlb CMA
 memory
Message-ID: <avLyOzQMBnHYLEst@thinkstation>
References: <20261106165142.2847916-1-usama.arif@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106165142.2847916-1-usama.arif@linux.dev>
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 08:51:42AM -0800, Usama Arif wrote:
> crashkernel=size,cma reserves a separate CMA pool. On systems that
> already reserve several gigabytes with hugetlb_cma= (which is common in
> the Meta fleet), the crash kernel cannot use that existing memory as
> part of its working set. With hugetlb_cma=6G, requesting another 2G
> with crashkernel=2G,cma brings the total CMA reservation to 8G, none of
> which can serve unmovable kernel allocations.
> 
> Use existing HugeTLB CMA memory first for crashkernel=size,cma and
> reserve dedicated CMA areas only for the remainder. With hugetlb_cma=6G,
> a 2G request reuses 2G without reserving more CMA. With hugetlb_cma=2G,
> a 4G request reuses 2G and reserves another 2G.
> 
> The full HugeTLB CMA pool remains available to HugeTLB and movable
> allocations during normal operation. After a crash, the capture kernel
> can use the selected ranges as working memory. The conventional
> reservation is still required to hold the kernel image and initrd.
> 
> The ,cma option already opts into excluding userspace memory from the
> vmcore. This includes allocated HugeTLB pages in the selected ranges,
> which the capture kernel can overwrite. The existing dump completeness
> and pending DMA risks apply to these ranges as well.
> 
> Have architecture code record the requested CMA size and perform the
> reservation in mm_core_init_early(), immediately after
> hugetlb_cma_reserve(). The HugeTLB CMA areas are then available for reuse
> while memblock can still reserve any remainder.
> 
> Use the existing four range slots for both reused and dedicated memory.
> Limit reused memory to the page-aligned request, account for dedicated
> CMA alignment, and report any shortfall. Ignore malformed optional sizes
> and reject requests that would overflow page rounding.
> 
> Suggested-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Usama Arif <usama.arif@linux.dev>

> ---
> v1 -> v2:
> - Use existing HugeTLB CMA memory first for crashkernel=size,cma and
>   reserve dedicated CMA areas only for the remainder. (Kiryl)

Suggested-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

