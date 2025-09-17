Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F52CAC59F
	for <kexec@archiver.kernel.org>; Wed, 17 Sep 2025 17:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9TFvqjlh2RTZrYKeLF5M597y/SnnQIvAiFkoD/c1uFE=; b=ya6JypMdd5Vwo2GMDI7EVlltg4
	4jBTp4D2DraIXD4n+tfd9363ZgUQAaCz67SGkYMvoDh2AmH6M0SiAl7Ga4ODYtomRUWoIkFUNDS/f
	DnRtJFFtItkzBhwlkXUWmtIvZeiC8/QbYZyoqa1OE6Y39uVDQB6NHZKPgHGp1tHDtvn+2gXr+a4tl
	QZrF2DAaKfamN7r3vjv2Mt2IfULqQzPhz9IN52RKWpzNmxouRfsy9/m+5Awp+VrjljbKGQM6KAR72
	n67RzVbZo6U9AHWjeDTv8g2sMex+u16GiihRvox0e1G5nb4vaozfTkwZC4OlDLdxd8G5iJ6RghKcV
	sUYK573A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uywKg-0000000DjJB-2TUY;
	Wed, 17 Sep 2025 17:52:42 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uywKe-0000000DjHP-2fjE
	for kexec@lists.infradead.org;
	Wed, 17 Sep 2025 17:52:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4B93C41831;
	Wed, 17 Sep 2025 17:52:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9E5C4CEF7;
	Wed, 17 Sep 2025 17:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758131559;
	bh=0SeyaT8+bz/I8XaOI5kg2LZdHBHQvUyjeoTzR45r53g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EcN9R/TroM+76zuwCRHHlFotgG8u6yNOacYJ/E+M27GlY7UvbEFph9bmCBH5FY0Wv
	 ZaetVpZzXhfM+zYpEfmtcfxYS0uojPUXq16GufgOBUnOKp1t4oZ6g6zdFECD5yYs2c
	 TjQAAv1NiqWkSOmcfxuDp77119G5Xmvkk7UTllZwFnb1hMs6maVdA+Ia5SyiG2HllO
	 qAIFTvFFaiwGIndHs9Jc5s3HK2CNXQ91I+1JQKbrigfQd4RsYibZTPUDIB3luJhX9E
	 eWhX6/q5eaaai/G5QCu5V4R8p7dFvt5w7NkodxOBhMkEYZomBskwmVV090EUefDbsT
	 8we5SSr+BgiwQ==
Date: Wed, 17 Sep 2025 20:52:28 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jason Miu <jasonmiu@google.com>
Cc: Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>,
	David Matlack <dmatlack@google.com>,
	David Rientjes <rientjes@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Joel Granados <joel.granados@kernel.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Petr Mladek <pmladek@suse.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Steven Chen <chenste@linux.microsoft.com>,
	Yan Zhao <yan.y.zhao@intel.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC v1 2/4] kho: Adopt KHO page tables and remove serialization
Message-ID: <aMr1XAKmyfzM8RCc@kernel.org>
References: <20250917025019.1585041-1-jasonmiu@google.com>
 <20250917025019.1585041-3-jasonmiu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917025019.1585041-3-jasonmiu@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250917_105240_719474_00089A1E 
X-CRM114-Status: GOOD (  27.49  )
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

Hi Jason,

On Tue, Sep 16, 2025 at 07:50:17PM -0700, Jason Miu wrote:
> Transition the KHO system to use the new page table data structures
> for managing preserved memory, replacing the previous xarray-based
> approach. Remove the serialization process and the associated
> finalization and abort logic.
> 
> Update the methods for marking memory to be preserved to use the KHO
> page table hierarchy. Remove the former system of tracking preserved
> pages using an xarray-based structure.
> 
> Change the method of passing preserved memory information to the next
> kernel to be direct. Instead of serializing the memory map, place the
> physical address of the `kho_order_table`, which holds the roots of
> the KHO page tables for each order, in the FDT. Remove the explicit
> `kho_finalize()` and `kho_abort()` functions and the logic supporting
> the finalize and abort states, as they are no longer needed. This
> simplifies the KHO lifecycle.
> 
> Enable the next kernel's initialization process to read the
> `kho_order_table` address from the FDT. The kernel will then traverse
> the KHO page table structures to discover all preserved memory
> regions, reserving them to prevent early boot-time allocators from
> overwriting them.
> 
> This architectural shift to using a shared page table structure
> simplifies the KHO design and eliminates the overhead of serializing
> and deserializing the preserved memory map.
> 
> Signed-off-by: Jason Miu <jasonmiu@google.com>
> ---
>  include/linux/kexec_handover.h |  17 --
>  kernel/kexec_handover.c        | 532 +++++----------------------------
>  2 files changed, 71 insertions(+), 478 deletions(-)
>  
> -/*
> - * TODO: __maybe_unused is added to the functions:
> - * kho_preserve_page_table()
> - * kho_walk_tables()
> - * kho_memblock_reserve()
> - * since they are not actually being called in this change.
> - * __maybe_unused will be removed in the next patch.
> - */
> -static __maybe_unused int kho_preserve_page_table(unsigned long pfn, int order)
> +static int kho_preserve_page_table(unsigned long pfn, int order)

Just merge this and the previous patch so that the patch will replace the
current preservation mechanism with a new one.

>  {
>  	unsigned long pa = PFN_PHYS(pfn);
>  
> @@ -365,8 +357,8 @@ static int __kho_walk_page_tables(int order, int level,
>  	return 0;
>  }
>  

...

> @@ -1023,12 +752,8 @@ int kho_preserve_folio(struct folio *folio)
>  {
>  	const unsigned long pfn = folio_pfn(folio);
>  	const unsigned int order = folio_order(folio);
> -	struct kho_mem_track *track = &kho_out.ser.track;
> -
> -	if (kho_out.finalized)
> -		return -EBUSY;
>  
> -	return __kho_preserve_order(track, pfn, order);
> +	return kho_preserve_page_table(pfn, order);

I don't think we should "rename" __kho_preserve_order() to
kho_preserve_page_table(). __kho_preserve_order() could use the new data
structure, or call the new implementation, but I don't see a reason to
replace it.

-- 
Sincerely yours,
Mike.

