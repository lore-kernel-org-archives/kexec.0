Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B920C71150
	for <kexec@archiver.kernel.org>; Fri, 13 Jun 2025 18:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IsAoIF1CZQf3gtSkOwS3qrfjhRTi/B0Neq7ex0a15C4=; b=eJMOzwMcJEkvxP+CAthOzm+qBa
	sZ24f5tfMnSK2xzGVJcsl3qt3Q7OqgtQeOQH48eg9ftRV3ZfOH+sbzoTbjcNvTf1hbOSTvXl0lfgE
	an2Xk0SpueVZUWFcbhV+0u2jN5boyu4363kyz4XsY+aoBsiWamCJBh/z34bpHZqLcOC0GpvN5fWoD
	SdbXm/psWB3TgEUKd+0YTJ1G8VmGh0Bd5D6xsN+l8v5MwvDCQK6ixCsWvioY1rEW0Ne74I7hITuZg
	HKGDDtnRfZbB3tp2gXuxfZwY27RceqaVAxehKQRxYt16mFboKdMBQx26/KZERTk3Y3t0kF9V3HQgr
	NHGkpGdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQ8y0-0000000HGzv-0G2r;
	Fri, 13 Jun 2025 18:17:28 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQ6sL-0000000Gzlp-0wc1
	for kexec@lists.infradead.org;
	Fri, 13 Jun 2025 16:03:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5EE524A3ED;
	Fri, 13 Jun 2025 16:03:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655E6C4CEE3;
	Fri, 13 Jun 2025 16:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749830608;
	bh=hG1xBkodWlqX8knsQvDzVtwCU36MdgTYDKkhHWNjPSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mTbIjhbv403WQAi4DQhff37b4AZJdRbbOsyAhYxEmvNGe5nqHK3GKZCI8clTkieZO
	 SjPQH6KWEDyjFnx8L+ivKgXfl+1fEYOi5ad7nPWoKCC2Mvm2CDJo7qVwp/qXZOhYmC
	 tYtbxnA2htUFOSeATzYOk4JoHzVKEJSJChnbgxl7/yAqSuHwKtLf82OEFbB8uJOg2J
	 /aQohI2FCyxuNzXEhzmHdk1u3yj7KyFSsUY3b89ZjNWgEbGBSE/FpCL+df2eGoNAx7
	 ZHvFOOA8wX/leY2BeRBUAyIIdIZPICGxhPn9j+4SJgez0K4ZF5uszIQPM9EOrvmGBZ
	 afj84W/1P4/nQ==
Date: Fri, 13 Jun 2025 19:03:21 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Changyuan Lyu <changyuanl@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Pratyush Yadav <ptyadav@amazon.de>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2] kho: initialize tail pages for higher order folios
 properly
Message-ID: <aExLyf9jWdO1gG0s@kernel.org>
References: <20250613125916.39272-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613125916.39272-1-pratyush@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250613_090329_313590_33B1E935 
X-CRM114-Status: GOOD (  25.00  )
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

On Fri, Jun 13, 2025 at 02:59:06PM +0200, Pratyush Yadav wrote:
> From: Pratyush Yadav <ptyadav@amazon.de>
> 
> Currently, when restoring higher order folios, kho_restore_folio() only
> calls prep_compound_page() on all the pages. That is not enough to
> properly initialize the folios. The managed page count does not
> get updated, the reserved flag does not get dropped, and page count does
> not get initialized properly.
> 
> Restoring a higher order folio with it results in the following BUG with
> CONFIG_DEBUG_VM when attempting to free the folio:
> 
>     BUG: Bad page state in process test  pfn:104e2b
>     page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffffffffffffffff pfn:0x104e2b
>     flags: 0x2fffff80000000(node=0|zone=2|lastcpupid=0x1fffff)
>     raw: 002fffff80000000 0000000000000000 00000000ffffffff 0000000000000000
>     raw: ffffffffffffffff 0000000000000000 00000001ffffffff 0000000000000000
>     page dumped because: nonzero _refcount
>     [...]
>     Call Trace:
>     <TASK>
>     dump_stack_lvl+0x4b/0x70
>     bad_page.cold+0x97/0xb2
>     __free_frozen_pages+0x616/0x850
>     [...]
> 
> Combine the path for 0-order and higher order folios, initialize the
> tail pages with a count of zero, and call adjust_managed_page_count() to
> account for all the pages instead of just missing them.
> 
> In addition, since all the KHO-preserved pages get marked with
> MEMBLOCK_RSRV_NOINIT by deserialize_bitmap(), the reserved flag is not
> actually set (as can also be seen from the flags of the dumped page in
> the logs above). So drop the ClearPageReserved() calls.
> 
> Fixes: fc33e4b44b271 ("kexec: enable KHO support for memory preservation")
> Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
> 
> Changes in v2:
> - Declare i in the loop instead of at the top.
> 
>  kernel/kexec_handover.c | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> index eb305e7e61296..ca525f794f6be 100644
> --- a/kernel/kexec_handover.c
> +++ b/kernel/kexec_handover.c
> @@ -157,11 +157,21 @@ static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
>  }
> 
>  /* almost as free_reserved_page(), just don't free the page */
> -static void kho_restore_page(struct page *page)
> +static void kho_restore_page(struct page *page, unsigned int order)
>  {
> -	ClearPageReserved(page);
> -	init_page_count(page);
> -	adjust_managed_page_count(page, 1);
> +	unsigned int nr_pages = (1 << order);
> +
> +	/* Head page gets refcount of 1. */
> +	set_page_count(page, 1);
> +
> +	/* For higher order folios, tail pages get a page count of zero. */
> +	for (unsigned int i = 1; i < nr_pages; i++)
> +		set_page_count(page + i, 0);
> +
> +	if (order > 0)
> +		prep_compound_page(page, order);
> +
> +	adjust_managed_page_count(page, nr_pages);
>  }
> 
>  /**
> @@ -179,15 +189,10 @@ struct folio *kho_restore_folio(phys_addr_t phys)
>  		return NULL;
> 
>  	order = page->private;
> -	if (order) {
> -		if (order > MAX_PAGE_ORDER)
> -			return NULL;
> -
> -		prep_compound_page(page, order);
> -	} else {
> -		kho_restore_page(page);
> -	}
> +	if (order > MAX_PAGE_ORDER)
> +		return NULL;
> 
> +	kho_restore_page(page, order);
>  	return page_folio(page);
>  }
>  EXPORT_SYMBOL_GPL(kho_restore_folio);
> --
> 2.47.1
> 

-- 
Sincerely yours,
Mike.

