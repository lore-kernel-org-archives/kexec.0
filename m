Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B0DDCE8D66
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 17:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qwjgF6s764EzS3wI/iHDEvAFk/om7nDcQRXdQNuY20c=; b=fpQRNO9TbOKYg+j7zDRvy31t3v
	o4U5ONJxW5ws4jo48qWCBxRV/Tn/0N/7GR0f9Mffv7RJEH9gLJj7og91j/alr/hzaW/R2Z6vtz5W9
	nlkffZKFS2j4k1nAF/vpyHgydNCexF7kGUS0gNTbjPhUMoAzZ3zWZREMEXzQtUZ5R0uLYLSmfA0Ui
	rdGQu7WiMTuBowYQpJ1Jwo+DscghMWZg163hhq3yS56LH5a2rgnXECUqFVdz4CIqa+a9JXClhICVj
	GvRpw6R/nUADUEz0rGwHouPscDNT5EK02/0MJpL/VSRyJlzQe8EItpmi9SpD1xc+NSY49FtpQhawb
	7pnd8jQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJxrz-0000000CryI-372i;
	Fri, 14 Nov 2025 17:45:59 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJxrx-0000000Crxu-3Lci
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 17:45:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7430B42A33;
	Fri, 14 Nov 2025 17:45:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727A6C19422;
	Fri, 14 Nov 2025 17:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763142357;
	bh=ozDxBmPfrFtagqwIh7x/8xt7ppkbKkHg3TCmX0I0wQg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TtaHtAXMQ/2sQIvDT4alfLUFdNYNzPGW+uauKrMPzKSM+0FH/I87nYoLJbk0LhHWy
	 XZ53G2XTZ35PIVxUrzHaRs3hWEbNcK3g8Sx0OUM4lrDRf/aNZqEZ4OgTfE+J5/twuZ
	 K5e0W1eHWPaBMUEcrlL00CxiyQaQ9gvylwrkAAIeM3GT7GZF51G5fCm6DoRW81pr5X
	 mV5ClXuKGxuwzNbmgiZ6D7Wp8zXAubW9qyPwgBYCsZvUrreBharqgX7bMDmikkxzF7
	 vuVTUOfaQl5HrDagVU7kLar+jXJWbHP+YqBOCVyfHmkvAAHkPvWE5WeMAcXkA8b/y6
	 QWFjON4XCexgQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org,  bhe@redhat.com,  rppt@kernel.org,
  jasonmiu@google.com,  arnd@arndb.de,  coxu@redhat.com,
  dave@vasilevsky.ca,  ebiggers@google.com,  graf@amazon.com,
  kees@kernel.org,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org
Subject: Re: [PATCH v1 13/13] kho: Introduce high-level memory allocation API
In-Reply-To: <20251114155358.2884014-14-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Fri, 14 Nov 2025 10:53:58 -0500")
References: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
	<20251114155358.2884014-14-pasha.tatashin@soleen.com>
Date: Fri, 14 Nov 2025 18:45:54 +0100
Message-ID: <mafs0qzu05wz1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_094557_882167_CEF3369F 
X-CRM114-Status: GOOD (  35.19  )
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

On Fri, Nov 14 2025, Pasha Tatashin wrote:

> Currently, clients of KHO must manually allocate memory (e.g., via
> alloc_pages), calculate the page order, and explicitly call
> kho_preserve_folio(). Similarly, cleanup requires separate calls to
> unpreserve and free the memory.
>
> Introduce a high-level API to streamline this common pattern:
>
> - kho_alloc_preserve(size): Allocates physically contiguous, zeroed
>   memory and immediately marks it for preservation.
> - kho_free_unpreserve(ptr, size): Unpreserves and frees the memory
>   in the current kernel.
> - kho_free_restore(ptr, size): Restores the struct page state of
>   preserved memory in the new kernel and immediately frees it to the
>   page allocator.

Nit: kho_unpreserve_free() and kho_restore_free() make more sense to me
since that is the order of operations. Having them the other way round
is kind of confusing.

Also, why do the free functions need size? They can get the order from
folio_order(). This would save users of the API from having to store the
size somewhere and make things simpler.

>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  include/linux/kexec_handover.h     |  22 +++++--
>  kernel/liveupdate/kexec_handover.c | 101 +++++++++++++++++++++++++++++
>  2 files changed, 116 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
> index 80ece4232617..76c496e01877 100644
> --- a/include/linux/kexec_handover.h
> +++ b/include/linux/kexec_handover.h
> @@ -2,8 +2,9 @@
>  #ifndef LINUX_KEXEC_HANDOVER_H
>  #define LINUX_KEXEC_HANDOVER_H
>  
> -#include <linux/types.h>
> +#include <linux/err.h>
>  #include <linux/errno.h>
> +#include <linux/types.h>
>  
>  struct kho_scratch {
>  	phys_addr_t addr;
> @@ -48,6 +49,9 @@ int kho_preserve_pages(struct page *page, unsigned int nr_pages);
>  int kho_unpreserve_pages(struct page *page, unsigned int nr_pages);
>  int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation);
>  int kho_unpreserve_vmalloc(struct kho_vmalloc *preservation);
> +void *kho_alloc_preserve(size_t size);
> +void kho_free_unpreserve(void *mem, size_t size);
> +void kho_free_restore(void *mem, size_t size);
>  struct folio *kho_restore_folio(phys_addr_t phys);
>  struct page *kho_restore_pages(phys_addr_t phys, unsigned int nr_pages);
>  void *kho_restore_vmalloc(const struct kho_vmalloc *preservation);
> @@ -101,6 +105,14 @@ static inline int kho_unpreserve_vmalloc(struct kho_vmalloc *preservation)
>  	return -EOPNOTSUPP;
>  }
>  
> +void *kho_alloc_preserve(size_t size)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +
> +void kho_free_unpreserve(void *mem, size_t size) { }
> +void kho_free_restore(void *mem, size_t size) { }
> +
>  static inline struct folio *kho_restore_folio(phys_addr_t phys)
>  {
>  	return NULL;
> @@ -122,18 +134,14 @@ static inline int kho_add_subtree(const char *name, void *fdt)
>  	return -EOPNOTSUPP;
>  }
>  
> -static inline void kho_remove_subtree(void *fdt)
> -{
> -}
> +static inline void kho_remove_subtree(void *fdt) { }
>  
>  static inline int kho_retrieve_subtree(const char *name, phys_addr_t *phys)
>  {
>  	return -EOPNOTSUPP;
>  }
>  
> -static inline void kho_memory_init(void)
> -{
> -}
> +static inline void kho_memory_init(void) { }
>  
>  static inline void kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
>  				phys_addr_t scratch_phys, u64 scratch_len)
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index a905bccf5f65..9f05849fd68e 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -4,6 +4,7 @@
>   * Copyright (C) 2023 Alexander Graf <graf@amazon.com>
>   * Copyright (C) 2025 Microsoft Corporation, Mike Rapoport <rppt@kernel.org>
>   * Copyright (C) 2025 Google LLC, Changyuan Lyu <changyuanl@google.com>
> + * Copyright (C) 2025 Pasha Tatashin <pasha.tatashin@soleen.com>
>   */
>  
>  #define pr_fmt(fmt) "KHO: " fmt
> @@ -1151,6 +1152,106 @@ void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
>  }
>  EXPORT_SYMBOL_GPL(kho_restore_vmalloc);
>  
> +/**
> + * kho_alloc_preserve - Allocate, zero, and preserve memory.
> + * @size: The number of bytes to allocate.
> + *
> + * Allocates a physically contiguous block of zeroed pages that is large
> + * enough to hold @size bytes. The allocated memory is then registered with
> + * KHO for preservation across a kexec.
> + *
> + * Note: The actual allocated size will be rounded up to the nearest
> + * power-of-two page boundary.
> + *
> + * @return A virtual pointer to the allocated and preserved memory on success,
> + * or an ERR_PTR() encoded error on failure.
> + */
> +void *kho_alloc_preserve(size_t size)
> +{
> +	struct folio *folio;
> +	int order, ret;
> +
> +	if (!size)
> +		return ERR_PTR(-EINVAL);
> +
> +	order = get_order(size);
> +	if (order > MAX_PAGE_ORDER)
> +		return ERR_PTR(-E2BIG);
> +
> +	folio = folio_alloc(GFP_KERNEL | __GFP_ZERO, order);
> +	if (!folio)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = kho_preserve_folio(folio);
> +	if (ret) {
> +		folio_put(folio);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return folio_address(folio);
> +}
> +EXPORT_SYMBOL_GPL(kho_alloc_preserve);
> +
> +/**
> + * kho_free_unpreserve - Unpreserve and free memory.
> + * @mem:  Pointer to the memory allocated by kho_alloc_preserve().
> + * @size: The original size requested during allocation. This is used to
> + *        recalculate the correct order for freeing the pages.
> + *
> + * Unregisters the memory from KHO preservation and frees the underlying
> + * pages back to the system. This function should be called to clean up
> + * memory allocated with kho_alloc_preserve().
> + */
> +void kho_free_unpreserve(void *mem, size_t size)
> +{
> +	struct folio *folio;
> +	unsigned int order;
> +
> +	if (!mem || !size)
> +		return;
> +
> +	order = get_order(size);
> +	if (WARN_ON_ONCE(order > MAX_PAGE_ORDER))
> +		return;
> +
> +	folio = virt_to_folio(mem);
> +	WARN_ON_ONCE(kho_unpreserve_folio(folio));

This is what I meant in my reply to the previous patch.
kho_unpreserve_folio() can be void now, so the WARN_ON_ONCE() is not
needed.

> +	folio_put(folio);
> +}
> +EXPORT_SYMBOL_GPL(kho_free_unpreserve);
> +
> +/**
> + * kho_free_restore - Restore and free memory after kexec.
> + * @mem:  Pointer to the memory (in the new kernel's address space)
> + * that was allocated by the old kernel.
> + * @size: The original size requested during allocation. This is used to
> + * recalculate the correct order for freeing the pages.
> + *
> + * This function is intended to be called in the new kernel (post-kexec)
> + * to take ownership of and free a memory region that was preserved by the
> + * old kernel using kho_alloc_preserve().
> + *
> + * It first restores the pages from KHO (using their physical address)
> + * and then frees the pages back to the new kernel's page allocator.
> + */
> +void kho_free_restore(void *mem, size_t size)

On restore side, callers are already using the phys addr directly. So do
kho_restore_folio() and kho_restore_pages() for example. This should
follow suit for uniformity. Would also save the callers a __va() call
and this function the __pa() call.

> +{
> +	struct folio *folio;
> +	unsigned int order;
> +
> +	if (!mem || !size)
> +		return;
> +
> +	order = get_order(size);
> +	if (WARN_ON_ONCE(order > MAX_PAGE_ORDER))
> +		return;
> +
> +	folio = kho_restore_folio(__pa(mem));
> +	if (!WARN_ON(!folio))

kho_restore_folio() already WARNs on failure. So the WARN_ON() here can
be skipped I think.

> +		free_pages((unsigned long)mem, order);

folio_put() here makes more sense since we just restored a folio.

> +}
> +EXPORT_SYMBOL_GPL(kho_free_restore);
> +
>  int kho_finalize(void)
>  {
>  	int ret;

-- 
Regards,
Pratyush Yadav

