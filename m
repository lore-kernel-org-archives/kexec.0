Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D21606D80C
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 09:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=m/Ha28I0;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GV++1Djw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=cgwH7+eb4DO1f1hZBo5/HU3TXgqaVoeCZLybivmvUJo=; b=m/Ha28I0ZoekgSVbOWtASUIoRj
	3CN4W7OcRmvlwo6dfVZb5j9tYanc10UYtAHVhjWTZXu/TdkuoDvVSj/P0Etad9L1d9wGdEkmeTE6y
	kOZcSsXo+QbJJnwA0H2LmPSNAxvqtREEIDjV3IAZ4rqb9Mz8YL/jX1b9mBy42uDiekyaAQfZhFb+O
	Fb90dRTtzZPCpaLSi4VQN0a9uqWn+5DN00qaJSAH63rVnrNptLZORCpwX177997iShjESh8nOMHmk
	sR8UsrQpISNvyIB0f8dU3XOqLnLHEvHScKZdzDSBY59Mv7re3d6LCoHOKZD+os0FnSAnyATjQb9VX
	aBzJafgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOB8Y-00000001oXO-1LkU;
	Tue, 03 Nov 2026 09:49:02 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOB8X-00000001oXD-2CCA;
	Tue, 03 Nov 2026 09:49:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9BC37605CB;
	Tue,  3 Nov 2026 09:49:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74261F000C1;
	Tue,  3 Nov 2026 09:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793699340;
	bh=cgwH7+eb4DO1f1hZBo5/HU3TXgqaVoeCZLybivmvUJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GV++1DjwxRqBZTgtqKQjH8FDRWWNjQ0UExyz4D4wPRG6CXHgHqlai8IgSZ5/B9AVO
	 fyr6sYpt+ugUguBnTwfa9EONvXK3lfiCOo8fFL2gesEHkb4WUZGfvT6fCfMJNsI31Z
	 Vw/EI3JAg4jrRuPcmYktzzSqUrEL7bUe5ETL5f1c0mbZHI+qxZizlD4FmPKJbOX8x8
	 UcFo7Cvy49IASUxO9wd2cXytT8/WMCHJsvvJP/mjOG1ZnH5zkongCwU5jFXzRP2W/i
	 UHtO33zaLptW2P5/6tQLOOQzYQ1+oU9XS++2xZHKEc1aCasgMoti+lnda5b6BltK8l
	 casrwkwEvaa2g==
Date: Tue, 3 Nov 2026 11:48:43 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	kas@kernel.org, kexec@lists.infradead.org,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	shakeel.butt@linux.dev, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, driver-core@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, rmikey@meta.com,
	riel@surriel.com, harry@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v6 3/7] mm/memory-failure: add hwpoison_boot_page() to
 flag an inherited frame
Message-ID: <aumt-4kfGGtoXuh-@kernel.org>
References: <20261016-hwpoison-kho-v6-0-f304255147da@debian.org>
 <20261016-hwpoison-kho-v6-3-f304255147da@debian.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016-hwpoison-kho-v6-3-f304255147da@debian.org>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 16, 2026 at 05:15:43AM -0700, Breno Leitao wrote:
> A kernel that kexecs inherits the frames its predecessor found
> hardware-poisoned. It has to carry them as PG_hwpoison in its own memmap,
> so that everything that already understands the flag covers them,
> including the kexec segment placement check.
> 
> Add a helper that sets the flag and counts the frame in
> num_poisoned_pages. It runs while the memmap is initialised, before
> memory_dev_init() has run. memblk_nr_poison_inc() divides by
> sections_per_block, which memory_dev_init() sets, so the helper
> increments num_poisoned_pages itself instead of calling
> num_poisoned_pages_inc().
> 
> An inherited frame is a hardware failure like any other, so the helper
> sets hw_memory_failure. Without it, unpoison_memory() accepts the frame,
> clears the flag and drops the last reference, which frees a frame that
> is still bad.
> 
> The helper also counts the frame as managed, as a frame that fails at
> run time stays counted. Memory offlining subtracts every frame of the
> block that is not PageOffline, so a frame that was never counted leaves
> the managed page count too low after an offline.
> 
> The per-node memory failure statistics are not updated. This kernel
> handled no failure, it only inherited one.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  mm/internal.h       | 5 +++++
>  mm/memory-failure.c | 8 ++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index da14c56fb24e11..4bd3bbce86e0ad 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1169,6 +1169,7 @@ void SetPageHWPoisonTakenOff(struct page *page);
>  void ClearPageHWPoisonTakenOff(struct page *page);
>  bool take_page_off_buddy(struct page *page);
>  bool put_page_back_buddy(struct page *page);
> +void __init hwpoison_boot_page(struct page *page);
>  struct task_struct *task_early_kill(struct task_struct *tsk, int force_early);
>  void add_to_kill_ksm(struct task_struct *tsk, const struct page *p,
>  		     struct vm_area_struct *vma, struct list_head *to_kill,
> @@ -1181,6 +1182,10 @@ static inline int unmap_poisoned_folio(struct folio *folio, unsigned long pfn, b
>  {
>  	return -EBUSY;
>  }
> +
> +static inline void hwpoison_boot_page(struct page *page)
> +{
> +}
>  #endif

We've been splitting internal.h to smaller headers, maybe it's time to add
"memory-faulure.h"?
  
>  extern unsigned long  __must_check vm_mmap_pgoff(struct file *, unsigned long,
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index a2ca8df501caee..d0d6b184ee469f 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -96,6 +96,14 @@ void num_poisoned_pages_sub(unsigned long pfn, long i)
>  		memblk_nr_poison_sub(pfn, i);
>  }
>  
> +void __init hwpoison_boot_page(struct page *page)
> +{
> +	SetPageHWPoison(page);
> +	atomic_long_inc(&num_poisoned_pages);
> +	hw_memory_failure = true;
> +	adjust_managed_page_count(page, 1);
> +}
> +
>  /*
>   * Return the first or the last hardware-poisoned online page in [start,
>   * start + size), or PHYS_ADDR_MAX if the range is clean.
> 
> -- 
> 2.53.0-Meta
> 

-- 
Sincerely yours,
Mike.

