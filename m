Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCB9EA7942
	for <kexec@archiver.kernel.org>; Wed,  4 Feb 2026 18:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xE30DIF7aMl5fJFbfMHsATsjIo296bw/JVseiyW00cs=; b=SAk7ffLQSxR171GqfOTXMzCx4O
	J8JIKd256OmEzi1BZA6SmESilGKMnb91Hk5mK7PZ/dK50xnL/pbvH+7Ww3QrdYkRMc0nsz24EX6nE
	oY6dSRU9qjU/pnsQZfsDGkHJ971qikssRiz/+f2Q4SFIMDXgkC3J04tWrir9KyF7UYeRPoa4d5Bdp
	/iPuYHX6bbjQXrGMT6RDTrndtDrOJje9LcTtwbHzcTMiWj6vZsJX4m/6sSP35mGqCSyn2Y9T58TFa
	9iisqZpQTfayCklv5nKbfufek55pG3Y/jlQM1kJRAIl3zBbmxbWii2jw7qGFi0X03G88M0L/vONXn
	QC5Yj9Mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnhs1-00000008wb8-2BR4;
	Wed, 04 Feb 2026 18:44:57 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnhs0-00000008wb2-15n9
	for kexec@lists.infradead.org;
	Wed, 04 Feb 2026 18:44:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 83F3360010;
	Wed,  4 Feb 2026 18:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9977C4CEF7;
	Wed,  4 Feb 2026 18:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770230695;
	bh=sxzUvwz2+H6f2P/hcewo6WsZzK2JbK2OdANari5N7ys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hbo8oTeRLq/G0/qNbB7YGWd3dqSCmtSDilBsD797FE8yTqU3sx0WcQ0oS9XbIIpUE
	 A1GWb4UWvEa2lM04K4NCr3r7qRI9cmv98vwCQgZVTms9IFLwe+y25M2E08EtQ5kXvU
	 TK/vUY9zjpNsqyq7VdV5gTZWHbI/+OiaQc22SSNijzPlesacMt+VEYZrtf5A9XAjj8
	 64ZUmYp1Uo1yret9r+Dq7qgLLV/WTAto0tXRshAdik+sxBzHCbBTvB711h3J8tuCnf
	 qjZNADObhwdt7CptI8g+ytiqygIxaDnlT0aWUKMEA2VDySzXf4rLHFIODj+3H4tvZv
	 xAjV+tyoF8VQg==
Date: Wed, 4 Feb 2026 20:44:48 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Evangelos Petrongonas <epetron@amazon.de>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Miu <jasonmiu@google.com>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	nh-open-source@amazon.com
Subject: Re: [PATCH] kho: add support for deferred struct page init
Message-ID: <aYOToJvAUU0dmW94@kernel.org>
References: <20251216084913.86342-1-epetron@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216084913.86342-1-epetron@amazon.de>
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

Hi Evangelos,

Are you planning to send a v2?

On Tue, Dec 16, 2025 at 08:49:12AM +0000, Evangelos Petrongonas wrote:
> When `CONFIG_DEFERRED_STRUCT_PAGE_INIT` is enabled, struct page
> initialization is deferred to parallel kthreads that run later
> in the boot process.
> 
> During KHO restoration, `deserialize_bitmap()` writes metadata for
> each preserved memory region. However, if the struct page has not been
> initialized, this write targets uninitialized memory, potentially
> leading to errors like:
> ```
> BUG: unable to handle page fault for address: ...
> ```
> 
> Fix this by introducing `kho_get_preserved_page()`,  which ensures
> all struct pages in a preserved region are initialized by calling
> `init_deferred_page()` which is a no-op when deferred init is disabled
> or when the struct page is already initialized.
> 
> Fixes: 8b66ed2c3f42 ("kho: mm: don't allow deferred struct page with KHO")
> Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
> ---
> ### Notes
> @Jason, this patch should act as a temporary fix to make KHO play nice
> with deferred struct page init until you post your ideas about splitting
> "Physical Reservation" from "Metadata Restoration".
> 
> ### Testing
> In order to test the fix, I modified the KHO selftest, to allocate more
> memory and do so from higher memory to trigger the incompatibility. The
> branch with those changes can be found in:
> https://git.infradead.org/?p=users/vpetrog/linux.git;a=shortlog;h=refs/heads/kho-deferred-struct-page-init
> 
> In future patches, we might want to enhance the selftest to cover
> this case as well. However, properly adopting the test for this
> is much more work than the actual fix, therefore it can be deferred to a
> follow-up series.
> 
> In addition attempting to run the selftest for arm (without my changes)
> fails with:
> ```
> ERROR:target/arm/internals.h:767:regime_is_user: code should not be reached
> Bail out! ERROR:target/arm/internals.h:767:regime_is_user: code should not be reached
> ./tools/testing/selftests/kho/vmtest.sh: line 113: 61609 Aborted
> ```
> I have not looked it up further, but can also do so as part of a
> selftest follow-up.
> 
>  kernel/liveupdate/Kconfig          |  2 --
>  kernel/liveupdate/kexec_handover.c | 19 ++++++++++++++++++-
>  2 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
> index d2aeaf13c3ac..9394a608f939 100644
> --- a/kernel/liveupdate/Kconfig
> +++ b/kernel/liveupdate/Kconfig
> @@ -1,12 +1,10 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  
>  menu "Live Update and Kexec HandOver"
> -	depends on !DEFERRED_STRUCT_PAGE_INIT
>  
>  config KEXEC_HANDOVER
>  	bool "kexec handover"
>  	depends on ARCH_SUPPORTS_KEXEC_HANDOVER && ARCH_SUPPORTS_KEXEC_FILE
> -	depends on !DEFERRED_STRUCT_PAGE_INIT
>  	select MEMBLOCK_KHO_SCRATCH
>  	select KEXEC_FILE
>  	select LIBFDT
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 9dc51fab604f..78cfe71e6107 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -439,6 +439,23 @@ static int kho_mem_serialize(struct kho_out *kho_out)
>  	return err;
>  }
>  
> +/*
> + * With CONFIG_DEFERRED_STRUCT_PAGE_INIT, struct pages in higher memory
> + * regions may not be initialized yet at the time KHO deserializes preserved
> + * memory. This function ensures all struct pages in the region are initialized.
> + */
> +static struct page *__init kho_get_preserved_page(phys_addr_t phys,
> +						  unsigned int order)
> +{
> +	unsigned long pfn = PHYS_PFN(phys);
> +	int nid = early_pfn_to_nid(pfn);
> +
> +	for (int i = 0; i < (1 << order); i++)
> +		init_deferred_page(pfn + i, nid);
> +
> +	return pfn_to_page(pfn);
> +}
> +
>  static void __init deserialize_bitmap(unsigned int order,
>  				      struct khoser_mem_bitmap_ptr *elm)
>  {
> @@ -449,7 +466,7 @@ static void __init deserialize_bitmap(unsigned int order,
>  		int sz = 1 << (order + PAGE_SHIFT);
>  		phys_addr_t phys =
>  			elm->phys_start + (bit << (order + PAGE_SHIFT));
> -		struct page *page = phys_to_page(phys);
> +		struct page *page = kho_get_preserved_page(phys, order);
>  		union kho_page_info info;
>  
>  		memblock_reserve(phys, sz);
> -- 
> 2.43.0
> 
> 
> 
> 
> Amazon Web Services Development Center Germany GmbH
> Tamara-Danz-Str. 13
> 10243 Berlin
> Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
> Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
> Sitz: Berlin
> Ust-ID: DE 365 538 597
> 

-- 
Sincerely yours,
Mike.

