Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA63C55171
	for <kexec@archiver.kernel.org>; Sun,  2 Aug 2026 11:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=STGiSUapaesQF2K76oCI6wHZd9Cr8woUwKiuHNgdKL4=; b=T+HtjCXauectZoVE3SPtbI+/31
	8yrGdqZHL+LT1fnoMV7dlEUp2/LG5AayT/g/o8Ki7Yjn2OftiHj5wYpNMVGCAyeBG3K94uly0Ll3C
	Ox/tIyGcpvM8uio3G59arB5XEHdE1Soh55QVQnVWQ870Lxe+SexCVk5rES/enQbMXLL9ZDm2NJSRG
	mkTacajtWBEuiI2Z4OTade1xCGis+yxe/oJDktyOvGUtnqj4uIhoiWzBP7kT1vnTJnpSP0ZaFBtgR
	VDXrhyj+VTAVEP323f58smJUAdSDgHkasRBocUJEPo3GyuGRIV5l+G+0mexAUOCTCLLqmYPzR9X+q
	D7RaQ94w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqUN0-0000000FZZ4-0Skb;
	Sun, 02 Aug 2026 11:28:42 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqUMz-0000000FZYy-0eSu
	for kexec@lists.infradead.org;
	Sun, 02 Aug 2026 11:28:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0FDF76057A;
	Sun,  2 Aug 2026 11:28:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723901F000E9;
	Sun,  2 Aug 2026 11:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785670119;
	bh=STGiSUapaesQF2K76oCI6wHZd9Cr8woUwKiuHNgdKL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bgj/n6JEEEDbd7ZONPgf9sWUyp2q0zCHD5DGDiLPtDCCeXXxHHnQ0MgseRuVbjK2R
	 wzUCfFQzRGWTiFuz/t9GTBfimgH4W30WZsfZh3nEYJ1o/tpHnHYujn4C6NExNR6oYu
	 POXvBVfY0egTeSd5rpRgbA+ldG/i4ioUZ2xRgSS4PmqQUCo8bat9fcxXjLfmBkgZFq
	 voXPsmDhnlt0HQGunKulmHWDB7Ickfb3LoUWTQUSdZFNh7BmCpG/a85jZc8NCcNnkq
	 A+4mNpmTgxQ8tKgyCX81yFWteNYHiTPRxSk1YPVfOx47bvbXCO/rv4HflO+AJ9CKSF
	 g0RblB7MwS/IQ==
Date: Sun, 2 Aug 2026 14:28:31 +0300
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
Subject: Re: [PATCH v6 00/22] kho: make boot time huge page allocation work
 nicely with KHO
Message-ID: <am8p31hKToQ3WfMT@kernel.org>
References: <20260801084833.1897543-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801084833.1897543-1-pratyush@kernel.org>
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

On Sat, Aug 01, 2026 at 10:48:09AM +0200, Pratyush Yadav wrote:
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> 
> Hi,
> 
> Gigantic huge page allocation is somewhat broken currently with KHO.
> 
> Fix this by introducing the concept of extended scratch areas. They are
> areas that the kernel discovers on boot by walking the radix tree and
> finding free memory ranges. See patch 10 for more details.
> 
> Muchun Song (1):
>   mm/mm_init: simplify deferred_free_pages() migratetype init
> 
> Pratyush Yadav (Google) (21):
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
>   memblock: always include KHO headers
>   memblock: make HugeTLB bootmem allocation work with KHO
>   memblock: add memblock_reserved_hugetlb_size()
>   kho: exclude hugetlb memory from scratch size calculation

This is applied now to kho-scratch branch in the liveupdate repo:

https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git/log/?h=kho-scratch

On top of mm-stable-6d098029de09 branch in Andrew's mm.git.

-- 
Sincerely yours,
Mike.

