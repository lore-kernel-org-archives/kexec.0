Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C958CEA8126
	for <kexec@archiver.kernel.org>; Tue, 10 Feb 2026 15:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tZqWOn6nM7zDPbQvvqMXHKEeR4Bn050FwLe6HRcqGmU=; b=xETv1k1RMDi+3cL151AS/BlZ8P
	fgBmOK2tw2EtBbxRDMKk0geF/qZimh69AFgcq4zHr8W6VqslCmNScyRNBQ8qdYVYQfPLTm6cyk2wv
	L+HfGOl3OAHfhmA6W2C7Rho0f7KU4u/H3wTwy4t3y4d9X6r0z+W2dhApNUv3Ts9YK5EAcsVBn6CHO
	MixDk/KqYb9zlEloqtYRE6ld0RSsArh8N5DH3utUvb2AYSRqTNVAJmErVB5fZapnu0tapkm9Bk825
	w2pBF10giukksxw4wwFBozrPONp8ec55hgjbBEM6ld6dH1TRbaxV+bvtHPaciwWHlTWAmQ9QOfyGS
	TwtfBz4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vppMw-0000000H6Ku-32ct;
	Tue, 10 Feb 2026 15:09:38 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vppMu-0000000H6JT-0qpr
	for kexec@lists.infradead.org;
	Tue, 10 Feb 2026 15:09:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 12A3A443A9;
	Tue, 10 Feb 2026 15:09:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA02C19421;
	Tue, 10 Feb 2026 15:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770736174;
	bh=s/009tO/uoAW8gW8CH7txHUInh05s9+ISLI8TUUR38M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VdoawcPU3pX+D8rF50VjcDAndYGaq86GorjJ9aukdRXku0zA3Fw6p2dOwqQtRNiSv
	 tgVK7NwQMvx3J20AB/r8Q3AGl02aw+fUizk+J/c0haKUfWpBnffZ9goqRWMnI9fkGY
	 P/JgUk3ev+ul4M6bvVbqWwu1W5D0T7/58XChisOa3QEcxa2sWJnYIbX4db2ilQ75xB
	 EZBehxpuhgZ181BYTfo2FdPCtz43kPHHhxvF8fDRPlFenll9X6bMOr3+vbMslvLi7V
	 Cq7F+fQ93cyTcBC+yxjG8aoLExRhaq6Z/aK5/q/x/Nw5F5UCptpkZHqBFiijoKDMkG
	 2idMLHv2Ujf7Q==
Date: Tue, 10 Feb 2026 17:09:28 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Michal Clapinski <mclapinski@google.com>
Cc: Evangelos Petrongonas <epetron@amazon.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] kho: add support for deferred struct page init
Message-ID: <aYtKKB-yKu-fwp3j@kernel.org>
References: <20260210130418.297153-1-mclapinski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210130418.297153-1-mclapinski@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260210_070936_302364_47C21248 
X-CRM114-Status: GOOD (  38.17  )
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

Hi Michal,

On Tue, Feb 10, 2026 at 02:04:18PM +0100, Michal Clapinski wrote:
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

Please drop md-style markup, plain text is fine :)
 
> Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
> Signed-off-by: Michal Clapinski <mclapinski@google.com>
> ---
> v2: updated a comment
> 
> I think we can't initialize those struct pages in kho_restore_page.
> I encountered this stack:
>   page_zone(start_page)
>   __pageblock_pfn_to_page
>   set_zone_contiguous
>   page_alloc_init_late
> 
> So, at the end of page_alloc_init_late struct pages are expected to be
> already initialized. set_zone_contiguous() looks at the first and last
> struct page of each pageblock in each populated zone to figure out if
> the zone is contiguous. If a kho page lands on a pageblock boundary,
> this will lead to access of an uninitialized struct page.
> There is also page_ext_init that invokes pfn_to_nid, which calls
> page_to_nid for each section-aligned page.
> There might be other places that do something similar. Therefore, it's
> a good idea to initialize all struct pages by the end of deferred
> struct page init. That's why I'm resending Evangelos's patch.
> 
> I also tried to implement Pratyush's idea, i.e. iterate over zones,
> then get node from zone. I didn't notice any performance difference
> even with 8GB of kho.
> 
> I repeated Evangelos's testing:
> In order to test the fix, I modified the KHO selftest, to allocate more
> memory and do so from higher memory to trigger the incompatibility. The
> branch with those changes can be found in:
> https://git.infradead.org/?p=users/vpetrog/linux.git;a=shortlog;h=refs/heads/kho-deferred-struct-page-init
> ---
>  kernel/liveupdate/Kconfig          |  2 --
>  kernel/liveupdate/kexec_handover.c | 23 ++++++++++++++++++++++-
>  2 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
> index 1a8513f16ef7..c13af38ba23a 100644
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
> index b851b09a8e99..26bb45b25809 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -457,6 +457,27 @@ static int kho_mem_serialize(struct kho_out *kho_out)
>  	return err;
>  }
>  
> +/*
> + * With CONFIG_DEFERRED_STRUCT_PAGE_INIT, struct pages in higher memory regions
> + * may not be initialized yet at the time KHO deserializes preserved memory.
> + * KHO uses the struct page to store metadata and a later initialization would
> + * overwrite it.
> + * Ensure all the struct pages in the preservation are
> + * initialized. deserialize_bitmap() marks the reservation as noinit to make
> + * sure they don't get re-initialized later.
> + */
> +static struct page *__init kho_get_preserved_page(phys_addr_t phys,
> +						  unsigned int order)
> +{
> +	unsigned long pfn = PHYS_PFN(phys);
> +	int nid = early_pfn_to_nid(pfn);

Getting nid when CONFIG_DEFERRED_STRUCT_PAGE_INIT=n is a pure overhead
because struct pages are initialized before KHO kho_mem_deserialize().

Other than that LGTM.

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
> @@ -467,7 +488,7 @@ static void __init deserialize_bitmap(unsigned int order,
>  		int sz = 1 << (order + PAGE_SHIFT);
>  		phys_addr_t phys =
>  			elm->phys_start + (bit << (order + PAGE_SHIFT));
> -		struct page *page = phys_to_page(phys);
> +		struct page *page = kho_get_preserved_page(phys, order);
>  		union kho_page_info info;
>  
>  		memblock_reserve(phys, sz);
> -- 
> 2.53.0.rc2.204.g2597b5adb4-goog
> 

-- 
Sincerely yours,
Mike.

