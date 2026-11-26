Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3275606A688
	for <kexec@archiver.kernel.org>; Thu, 26 Nov 2026 18:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FJmmwvBU;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OGnBv2u0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=SRMbopjT2ZDCp3S0bduHH4K2gvQ2HvHqic8ibWdFK5o=; b=FJmmwvBUu/34+Dd7UvhKHyVNbU
	0chBgIyBvqD7b/3es4dVYBdlGC0uvQoSlBtGxpRJZmnbYkuDBBS4j3aO43gfJUhTHte2ekj9EiYLB
	muuZ+V20/oN0Z82lKCSFv451ioro0WiB0SKYCRhasyUPjX25E+MAaOsVxSWcUepRVJska0mxyIWjH
	LmkiinuAb4bN3+cheYpwpC86wgET4nyY63e/I0QB37JWwKi7j1wdA2FZUKHvEjZE+dKATENF5925H
	4X/XrMBmirsUOskE7+jjQip+MpOEH+hnXE0JgyJN91nQ2Zqy7W9eOWCxoL89wKgBEPZm/8ESeoDdr
	LI/zofQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWdoi-0000000E7tg-3irT;
	Thu, 26 Nov 2026 18:03:32 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWdoi-0000000E7tR-0VLB;
	Thu, 26 Nov 2026 18:03:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D993F43BD5;
	Thu, 26 Nov 2026 18:03:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F3F1F00AE3;
	Thu, 26 Nov 2026 18:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795716211;
	bh=SRMbopjT2ZDCp3S0bduHH4K2gvQ2HvHqic8ibWdFK5o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=OGnBv2u03WCFZWsDn0SqFklZyJny8+Af7jkPORwbwrdfJO9Uuyh3rw7lkea/8Q6vB
	 cSIp8xQifnWtaWmwzYmEuwcFqqquwhEDZYU9qydrjf+sBZlYdV0Uh4OcohneorzOIF
	 dQPa+xbeiqQcdPDC9Oa7jdvVgs4qB+n6553AGLoeNcTPRVh325vt+HhS5HZHGL1sQs
	 OkUadX01xuDVnzUkH625JGfejnQ3/CAK3j6h3DWaPExj7QpjphDplmcLYj/MRIcgd0
	 eVototx5kDwOQb/DevkWMQPYQDKm10UmfNq6zCKguaXM2lSgE0EpwfzgMQkEYxMgnP
	 jCJ1NS7tAygTQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Tarun Sahu <tarunsahu@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,  Mike Rapoport
 <rppt@kernel.org>,  robin.murphy@arm.com,  maz@kernel.org,
  will@kernel.org,  David Matlack <dmatlack@google.com>,  Alexander Graf
 <graf@amazon.com>,  seanjc@google.com,  jgg@nvidia.com,
  loganodell@google.com,  arnd@arndb.de,  dwmw2@infradead.org,
  baolu.lu@linux.intel.com,  Bjorn Helgaas <bhelgaas@google.com>,
  oupton@kernel.org,  alex@shazbot.org,  gle.com@google.com,
  pbonzini@redhat.com,  Andrew Morton <akpm@linux-foundation.org>,
  kevin.tian@intel.com,  joro@8bytes.org,  kvmarm@lists.linux.dev,
  linux-pci@vger.kernel.org,  Pratyush Yadav <pratyush@kernel.org>,
  kexec@lists.infradead.org,  kvm@vger.kernel.org,  iommu@lists.linux.dev,
  linux-arm-kernel@lists.infradead.org,  skhawaja@google.com,
  sagis@google.com,  linux-arch@vger.kernel.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 07/19] kho: vmalloc: Add the feature header
In-Reply-To: <20261110050202.529473-8-tarunsahu@google.com> (Tarun Sahu's
	message of "Tue, 10 Nov 2026 05:01:50 +0000")
References: <20261110050202.529473-1-tarunsahu@google.com>
	<20261110050202.529473-8-tarunsahu@google.com>
Date: Thu, 26 Nov 2026 18:03:23 +0000
Message-ID: <2vxzh5h3wjv8.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10 2026, Tarun Sahu wrote:

> Register struct kho_vmalloc with the KHO serialization feature header
> mechanism to allow future additive fields or feature extensions without
> breaking live update ABI compatibility.
>
> Add DECLARE_KHO_SER(kho_vmalloc, 16, 0, 0) to register the 16-byte
> structure with 0 required and 0 optional features. Update function
> prototypes in include/linux/kexec_handover.h to take
> DECLARE_KHO_SER_HDR(kho_vmalloc, *fhdr) parameters, documenting which
> registered structure the feature header belongs to while enforcing
> compile-time type verification.
>
> In kho_preserve_vmalloc(), initialize the feature header with
> kho_ser_init() and access the payload fields via kho_ser_payload().
> In kho_restore_vmalloc(), validate incoming required features with
> kho_ser_validate() and access payload fields via kho_ser_payload().
> In kho_unpreserve_vmalloc(), access payload fields via kho_ser_payload().
> The chunk page format and traversal remain unchanged.
>
> Update memfd_luo and test_kho to pass typed feature header pointers
> and use kho_ser_size() for allocation sizing.
>
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
[...]
> diff --git a/include/linux/kho/abi/memfd.h b/include/linux/kho/abi/memfd.h
> index 7b49dd6d7e2a..b0597c438973 100644
> --- a/include/linux/kho/abi/memfd.h
> +++ b/include/linux/kho/abi/memfd.h
> @@ -80,9 +80,9 @@ static_assert(!IS_ENABLED(CONFIG_64BIT) ||
>   * @seals:     The seals present on the memfd. The seals are uABI so it is safe
>   *             to directly use them in the ABI.
>   * @flags:     Flags for the file. Unused flag bits must be set to 0.
> - * @nr_folios: Number of folios in the folios array.
> - * @folios:    Pointer to KHO vmalloc descriptor for the array of
> - *             struct memfd_luo_folio_ser.
> + * @nr_folios:   Number of folios in the folios array.
> + * @folios_fhdr: Pointer to KHO vmalloc descriptor for the array of
> + *               struct memfd_luo_folio_ser.
>   */
>  struct memfd_luo_ser {
>  	u64 pos;
> @@ -90,7 +90,7 @@ struct memfd_luo_ser {
>  	u32 seals;
>  	u32 flags;
>  	u64 nr_folios;
> -	DECLARE_KHOSER_PTR(folios, struct kho_vmalloc *);
> +	DECLARE_KHOSER_PTR(folios_fhdr, DECLARE_KHO_SER_HDR(kho_vmalloc, *));

This doesn't _only_ point to the feature header. It points to the
vmalloc buffer of of folios, conceptually. So it should be called
"folios". Reading folios_fhdr everywhere is super confusing and hard to
read. Users of KHO vmalloc should be pointing to the KHO malloc
serialization structure, not to its headers or so on.

The feature header is an implementation detail of kho_vmalloc (same for
others). It should not be visible to its callers.

>  };
>  
>  static_assert(sizeof(struct memfd_luo_ser) == 40);
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 641a3b4c88fb..6e428df717cc 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -1378,20 +1378,20 @@ static void kho_vmalloc_unpreserve_chunk(struct kho_vmalloc_chunk *chunk,
>  /**
>   * kho_preserve_vmalloc - preserve memory allocated with vmalloc() across kexec
>   * @ptr: pointer to the area in vmalloc address space
> - * @preservation: placeholder for preservation metadata
> + * @fhdr:         placeholder for preservation metadata
>   *
>   * Instructs KHO to preserve the area in vmalloc address space at @ptr. The
>   * physical pages mapped at @ptr will be preserved and on successful return
> - * @preservation will hold the physical address of a structure that describes
> - * the preservation.
> + * @fhdr will hold the preservation metadata.
>   *
>   * NOTE: The memory allocated with vmalloc_node() variants cannot be reliably
>   * restored on the same node
>   *
>   * Return: 0 on success, error code on failure
>   */
> -int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation)
> +int kho_preserve_vmalloc(void *ptr, DECLARE_KHO_SER_HDR(kho_vmalloc, *fhdr))
>  {
> +	struct kho_vmalloc *vmalloc_ser;
>  	struct kho_vmalloc_chunk *chunk;
>  	struct vm_struct *vm = find_vm_area(ptr);
>  	unsigned int order, flags, nr_contig_pages;
> @@ -1404,13 +1404,18 @@ int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation)
>  	if (vm->flags & ~KHO_VMALLOC_SUPPORTED_FLAGS)
>  		return -EOPNOTSUPP;
>  
> +	kho_ser_init(fhdr, kho_vmalloc);
> +
> +	vmalloc_ser = kho_ser_payload(fhdr, kho_vmalloc);
> +
>  	flags = vmalloc_flags_to_kho(vm->flags);
>  	order = get_vm_area_page_order(vm);
> +	vmalloc_ser->order = order;

Nit: Why is this moving around? Seems like a stray change.

Also, renaming preservation to vmalloc_ser adds a lot of noise to your
diff. Perhaps keep it as-is for now?
>  
>  	chunk = new_vmalloc_chunk(NULL);
>  	if (!chunk)
>  		return -ENOMEM;
> -	KHOSER_STORE_PTR(preservation->first, chunk);
> +	KHOSER_STORE_PTR(vmalloc_ser->first, chunk);
>  
>  	nr_contig_pages = (1 << order);
>  	for (int i = 0; i < vm->nr_pages; i += nr_contig_pages) {
[...]

-- 
Regards,
Pratyush Yadav

