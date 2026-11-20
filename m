Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740D1606A330
	for <kexec@archiver.kernel.org>; Fri, 20 Nov 2026 16:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=QePzERZx;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H/VuAI5B
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ZFb+S8Es0NvUmNBR5T6fgVNGrRH2yKZK48f5XbLVIEc=; b=QePzERZxDnqwzHfc3fs66OUC8p
	lMbxnUNrsqfShcXiWwOAYgWaY9jFytDy78ntNq6z7RzXcVeQg4/jV/D9uGXJYJNMPo+g0SBSZHHbr
	KUoJ77xs7f6OKyqlbwQWEYSN20qaddsw4CwuExr86F8Tx9zjz8ojuYy5xQ1pEL2BHUwZ/my50/Dmt
	pAXwha4gKByEorCnFeZt3x0kwom8JGdSZQoKF5YaQHcSOrrWPbYMZATiEJF8L1bjBf6ChostzWIvz
	R1rMuKO3Z5ZLLzpPNdCocZeyZUBL7Ns7+RvyGLdJOAG5koBR/hxhLwB1BRMX5vo48DK3627QVhVlf
	jcnKiriw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xURCi-0000000FWVy-4713;
	Fri, 20 Nov 2026 16:11:12 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xURCg-0000000FWVS-0qbO;
	Fri, 20 Nov 2026 16:11:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9ACC640C12;
	Fri, 20 Nov 2026 16:11:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A251F000C6;
	Fri, 20 Nov 2026 16:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795191069;
	bh=ZFb+S8Es0NvUmNBR5T6fgVNGrRH2yKZK48f5XbLVIEc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=H/VuAI5BtuQwQd0zk9hcNYwSPn6N63WihBmZ3f6agPjw5j6X4nhjl+xkuBInj2K3G
	 pOag/mfhsLJCuDBPE43lBZguYkWm5Q0XnOYHt8I9NqdQ+atTKMgFYlb1IaF+jtQGld
	 3sUfi6lcLYmIyXlLtnVutUfX01YNRwxTD426bjxP/ztOBKmBROpGn/s6ksznIb2w4q
	 Au1te+hWzLmOyeSjczvD2gxa37Gi2iRY6JeY1uNgS+FOo6aHN7HdwWzWJ76IhqubZC
	 I7wV52HU+JBPo3Q8L36yOGgOyjynFxkC/8obE8WBrvul2HbGE4EceWsI1QomsynUz+
	 KVYj1KF0dneuA==
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
Subject: Re: [PATCH v4 02/19] kho: block: Record the entry size in the block
 header
In-Reply-To: <20261110050202.529473-3-tarunsahu@google.com> (Tarun Sahu's
	message of "Tue, 10 Nov 2026 05:01:45 +0000")
References: <20261110050202.529473-1-tarunsahu@google.com>
	<20261110050202.529473-3-tarunsahu@google.com>
Date: Fri, 20 Nov 2026 16:11:01 +0000
Message-ID: <2vxz8q2n1o16.fsf@kernel.org>
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

> Subsystems using the KHO Serialization Blocks framework currently do
> not record the serialized entry size in the block header. The entry size
> is only known to individual callers, which must track and store it in an
> owning serialized data structure. If a newer source kernel adds fields
> to an entry, the changed entry size breaks the stride when an older
> target kernel iterates over blocks.
>
> Add an entry_size field to struct kho_block_header_ser. On the outgoing
> side, record bs->entry_size into every block header during allocation.
> During restoration, derive the entry stride directly from the block
> header instead of relying on caller-supplied dimensions. The
> kho_block_set_init() interface remains unchanged. A zero entry size,
> or one that differs between blocks of a set, is rejected during
> restoration.

Yeah, I agree with David here. It makes little sense to have callers
pass in the entry size only to have it ignored (or, only used for
rejection). It would be much better to use the recorded entry size and
hand it over to callers.

>
> This change modifies the serialized layout of struct kho_block_header_ser
> and shifts the offset of serialized entries within preserved blocks.
> Bump KHO_FDT_COMPATIBLE from kho-v4 to kho-v5 so that pre-v5 and post-v5
> kernels cleanly reject mismatched handover state during boot. Also
> update the stale compatible string example in the documentation.
>
> Suggested-by: Pratyush Yadav <pratyush@kernel.org>
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
> ---
>  include/linux/kho/abi/block.h          | 10 ++++----
>  include/linux/kho/abi/kexec_handover.h |  6 ++---
>  kernel/liveupdate/kho_block.c          | 32 +++++++++++++++++++++++---
>  3 files changed, 38 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/kho/abi/block.h b/include/linux/kho/abi/block.h
> index 36bdbaf9b3b8..a40b0906c821 100644
> --- a/include/linux/kho/abi/block.h
> +++ b/include/linux/kho/abi/block.h
> @@ -40,9 +40,10 @@
>  
>  /**
>   * struct kho_block_header_ser - Header for the serialized data block.
> - * @next:  Physical address of the next struct kho_block_header_ser.
> - * @count: The number of entries that immediately follow this header in the
> - *         memory block.
> + * @next:       Physical address of the next struct kho_block_header_ser.
> + * @count:      The number of entries that immediately follow this header in the
> + *              memory block.
> + * @entry_size: The size in bytes of each serialized entry in the block.
>   *
>   * This structure is located at the beginning of a block of physical memory
>   * preserved across a kexec. It provides the necessary metadata to interpret
> @@ -51,9 +52,10 @@
>  struct kho_block_header_ser {
>  	u64 next;
>  	u64 count;
> +	u64 entry_size;

I think this is the wrong place to put this. This header goes before
each block, so it should only hold metadata _for this block_, not for
the whole data structure. Because if you do that, you end up having the
field present in each block, but only the first block is special and the
value is only valid there. The feature header coming later makes this
problem worse.

I think we should follow down the lines of kho_vmalloc and have a
out-of-band structure that describes the whole block set, and then each
block only holds metadata relevant to it.

So this would look like:

	struct kho_block_ser {
		DECLARE_KHOSER_PTR(first, struct kho_block_header_ser *);
		u64 entry_size;
		/* Other things like flags, size, etc... */
	};

[...]

-- 
Regards,
Pratyush Yadav

