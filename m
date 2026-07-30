Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A4BEC54FDF
	for <kexec@archiver.kernel.org>; Thu, 30 Jul 2026 07:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Os9dgFvLa7OaBZRPPv98Vo5UROeltiAo6YFGnDGfHRI=; b=IQZztGgOgwXsm6S1PadukQ47eZ
	6LGoXbhr4VGLATBeVdhSUjjK/7R4ia+c3QeGcT7xdvf9P4k+8x7e3KQc/EIWl8SLByU8bANZRoO27
	fmvbvcxPOEuDWCk6tNo7op2mFkrGcfFF/e6ZdN3IrFoJSaVrTDq5Nj4g9zLtInJZb+2sKYWmgR3JN
	wz8tHEspMepAhbJwKErlp1PwlsDSKG/rjDrqEgeOYYABL0nbiZbqx5nLXAOcxBIyp0nONfVxeW4MC
	4gzeRC9UwsJ/8YpalMgLhmnvhMltrezuNuqz7uVusNN+lv4ecmu/dRRsavGatjeR+KpTRR4eyGUGn
	ExyYpVOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpL7U-00000009jYf-1uMo;
	Thu, 30 Jul 2026 07:23:56 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpL7Q-00000009jYP-2QED
	for kexec@lists.infradead.org;
	Thu, 30 Jul 2026 07:23:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 07524400AE;
	Thu, 30 Jul 2026 07:23:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133881F000E9;
	Thu, 30 Jul 2026 07:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785396231;
	bh=Os9dgFvLa7OaBZRPPv98Vo5UROeltiAo6YFGnDGfHRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jHj6GHG+B6LgtjHEN9lD3r0pHdLDN+4kYoIS1VogXbaHwhDQ+DRNw19Wtm3HcxLVv
	 iAF5ezxDHjmMOOm4WuZQypQ/XfMT4Pw6Y4ybYPZwHN6f4GDG6DIfbgwpOp3GAZyVT9
	 OfRTqZ51g49gULmex43tFprNxYVrVBkKDfFVow2rJa8asavexLSTKdQoT7CSUiF93T
	 YtdwNIe8jQPzVp+WdhrhWq0DPLI8WOshgBVxTWWl1Kud5DYndfXSqA4kvyJEzwTyE5
	 2MAxFIhxHhTM02fFqUhgN+JXPlGtks6I/DHxvDiBX09F2bKGjgiH9dDlqzT9bghJhg
	 L8lfRYaJWm2jQ==
Date: Thu, 30 Jul 2026 10:23:44 +0300
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
Subject: Re: [PATCH v5 17/22] mm/mm_init: don't rely on memblock to get KHO
 scratch migratetype
Message-ID: <amr8ADvAiJE3ZYKF@kernel.org>
References: <20260729145610.2827231-1-pratyush@kernel.org>
 <20260729145610.2827231-18-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729145610.2827231-18-pratyush@kernel.org>
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

On Wed, Jul 29, 2026 at 04:56:02PM +0200, Pratyush Yadav wrote:
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> 
> Currently struct page init via memmap_init() or deferred_init_memmap()
> only queries the migrate type from KHO for each discrete memory range.
> That works currently since KHO scratch memory has a different memory
> type so it is always it its own region.
> 
> An upcoming patch will add support for discovering blocks of memory with
> no preservations and it will mark it as MEMBLOCK_KHO_SCRATCH to allow
> allocations from them. This can lead to the bootmem KHO scratch areas to
> be merged into larger free ranges. This merging breaks the selection of
> migrate type.
> 
> Get rid of memblock_is_kho_scratch_memory(). Instead, use
> kho_scratch_overlap() to decide the migrate type of the PFN. Since
> kho_scratch_migratetype() only uses KHO functions, move it to
> kexec_handover.h.
> 
> Instead of calling kho_scratch_migratetype() once for each free range,
> call it once for each pageblock. Update
> pageblock_migratetype_init_range() and memmap_init_range() to do so.
> 
> Since the migrate type is now evaluated for each pageblock and not each
> free range, drop the migratetype arguments to deferred_free_pages() and
> memmap_init_zone_range() and use MIGRATE_MOVABLE directly.
> 
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> ---
>  include/linux/kexec_handover.h | 15 +++++++++++++++
>  include/linux/memblock.h       | 19 -------------------
>  mm/memblock.c                  | 10 ----------
>  mm/mm_init.c                   | 27 +++++++++++++--------------
>  4 files changed, 28 insertions(+), 43 deletions(-)
> 
> diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
> index 18ba417f1ada..c83ec4a15fe7 100644
> --- a/include/linux/kexec_handover.h
> +++ b/include/linux/kexec_handover.h
> @@ -5,6 +5,7 @@
>  #include <linux/err.h>
>  #include <linux/errno.h>
>  #include <linux/types.h>
> +#include <linux/mmzone.h>

Should have been mm.h, kbuild bot is unhappy otherwise :)

https://lore.kernel.org/all/202607301001.ARjK0D4v-lkp@intel.com

I can fix it while applying.

-- 
Sincerely yours,
Mike.

