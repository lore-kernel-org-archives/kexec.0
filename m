Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34294606A88E
	for <kexec@archiver.kernel.org>; Sun, 15 Nov 2026 17:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ldqoVS/x;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ddU/m/1O
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=fcvhgN18/XYE74JlLdDetDkiu4aCL1FUsX9bNl85AkY=; b=ldqoVS/xNkO4ZUTiCoUSBH+e+u
	wAOsOhJhf/8DOxUp83xjPQ880GbcKGDLDz3PWexPMUZqBw3RW+qZ7lH9js9keHNDC5lDKPjQDLjXJ
	ZrQ39ERSTFeWbK0sll9LZjlSxb6LWaLUvk7H3xmv5RgDRCdpm/i9uKov/REN28OzDaoSZCGx0dVos
	AjaBiLsbgIu4aGEfxdWHwYDcwq5nWhNrC8JHjgTdyWxw4W2gFnIgo8V9ckZ09DX3/AqaxxaP4qfB4
	tZ1BGUSAy473+NNswvrdUIxtRUL8ZhaXzsNq90WiWpVtVWZaiFr+hFs7Whl1GF/cUlaC5U1m+5U6+
	gTMV2xkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSe8m-00000000Geb-3CnQ;
	Sun, 15 Nov 2026 17:35:44 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSe8l-00000000Ge6-25Bd;
	Sun, 15 Nov 2026 17:35:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E6DAC4175A;
	Sun, 15 Nov 2026 17:35:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20351F000C7;
	Sun, 15 Nov 2026 17:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794764142;
	bh=fcvhgN18/XYE74JlLdDetDkiu4aCL1FUsX9bNl85AkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ddU/m/1Ov9hH52C17Sf1BxhZx39khyeZ73nswpSZtY3X610LZRBj0Idbdtnd8O4T/
	 EN4L7mJHIP90IjKjPaVbuRABJRbCOFNs789jv1X/5x2xRUJV9rkbUsZCBa9T1q7cIu
	 mXovLK/9jRwlwDkMfLKVRB6VcXBPkMhFXDlxbOv54EPM9joTvwF761sm+dzD5jiPKA
	 ku00S0Tc0YtsZmBVrp36zvAcqfUSnx0FPUQpd4J20hQkwHNyXRghC2rIG3RrOXVC5u
	 MOVkj0NIqYJuFV43NNl2an85+Dbj/v1rVbrpoXoYLzDFTOHSo1H/UsUmcXwD1o8oaK
	 9mR1epb9dYlUQ==
Date: Sun, 15 Nov 2026 19:35:29 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Tarun Sahu <tarunsahu@google.com>, robin.murphy@arm.com, maz@kernel.org,
	will@kernel.org, David Matlack <dmatlack@google.com>,
	Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com,
	loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org,
	baolu.lu@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>,
	oupton@kernel.org, alex@shazbot.org, gle.com@google.com,
	pbonzini@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
	kevin.tian@intel.com, joro@8bytes.org, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>,
	kexec@lists.infradead.org, kvm@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	skhawaja@google.com, sagis@google.com, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/19] kho: block: Record the entry size in the block
 header
Message-ID: <avntYdLF2xvDh47A@kernel.org>
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-3-tarunsahu@google.com>
 <DMRK0PU0VCN3.15F59WLOQ05P4@soleen.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DMRK0PU0VCN3.15F59WLOQ05P4@soleen.com>
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

On Tue, Nov 10, 2026 at 08:10:32AM -0500, Pasha Tatashin wrote:
> On Tue Nov 10, 2026 at 12:01 AM EST, Tarun Sahu wrote:
> > Subsystems using the KHO Serialization Blocks framework currently do
> > not record the serialized entry size in the block header. The entry size
> > is only known to individual callers, which must track and store it in an
> > owning serialized data structure. If a newer source kernel adds fields
> > to an entry, the changed entry size breaks the stride when an older
> > target kernel iterates over blocks.
> >
> > Add an entry_size field to struct kho_block_header_ser. On the outgoing
> > side, record bs->entry_size into every block header during allocation.
> > During restoration, derive the entry stride directly from the block
> > header instead of relying on caller-supplied dimensions. The
> > kho_block_set_init() interface remains unchanged. A zero entry size,
> > or one that differs between blocks of a set, is rejected during
> > restoration.
> >
> > This change modifies the serialized layout of struct kho_block_header_ser
> > and shifts the offset of serialized entries within preserved blocks.
> > Bump KHO_FDT_COMPATIBLE from kho-v4 to kho-v5 so that pre-v5 and post-v5
> > kernels cleanly reject mismatched handover state during boot. Also
> > update the stale compatible string example in the documentation.
> >
> > Suggested-by: Pratyush Yadav <pratyush@kernel.org>
> > Signed-off-by: Tarun Sahu <tarunsahu@google.com>
> > ---
> >  include/linux/kho/abi/block.h          | 10 ++++----
> >  include/linux/kho/abi/kexec_handover.h |  6 ++---
> >  kernel/liveupdate/kho_block.c          | 32 +++++++++++++++++++++++---
> >  3 files changed, 38 insertions(+), 10 deletions(-)
> >
> > diff --git a/include/linux/kho/abi/block.h b/include/linux/kho/abi/block.h
> > index 36bdbaf9b3b8..a40b0906c821 100644
> > --- a/include/linux/kho/abi/block.h
> > +++ b/include/linux/kho/abi/block.h
> > @@ -40,9 +40,10 @@
> >  
> >  /**
> >   * struct kho_block_header_ser - Header for the serialized data block.
> > - * @next:  Physical address of the next struct kho_block_header_ser.
> > - * @count: The number of entries that immediately follow this header in the
> > - *         memory block.
> > + * @next:       Physical address of the next struct kho_block_header_ser.
> > + * @count:      The number of entries that immediately follow this header in the
> > + *              memory block.
> > + * @entry_size: The size in bytes of each serialized entry in the block.
> >   *
> >   * This structure is located at the beginning of a block of physical memory
> >   * preserved across a kexec. It provides the necessary metadata to interpret
> > @@ -51,9 +52,10 @@
> >  struct kho_block_header_ser {
> >  	u64 next;
> >  	u64 count;
> > +	u64 entry_size;
> >  };
> >  
> > -static_assert(sizeof(struct kho_block_header_ser) == 16);
> > +static_assert(sizeof(struct kho_block_header_ser) == 24);
> >  static_assert(!IS_ENABLED(CONFIG_64BIT) ||
> >  	      __alignof__(struct kho_block_header_ser) == 8);
> 
> The above change goes away once my comment on the previous patch 
> is addressed.
> 
> >  
> > diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/abi/kexec_handover.h
> > index 2f4fb9c63942..6f12f5037ea5 100644
> > --- a/include/linux/kho/abi/kexec_handover.h
> > +++ b/include/linux/kho/abi/kexec_handover.h
> > @@ -41,7 +41,7 @@
> >   *   restore the preserved data.::
> >   *
> >   *     / {
> > - *         compatible = "kho-v3";
> > + *         compatible = "kho-v5";
> >   *
> >   *         preserved-memory-map = <0x...>;
> >   *
> > @@ -62,7 +62,7 @@
> >   *     };
> >   *
> >   *   Root KHO Node (/):
> > - *     - compatible: "kho-v3"
> > + *     - compatible: "kho-v5"
> 
> These are just examples, don't update them.
> 
> >   *
> >   *       Identifies the overall KHO ABI version.
> >   *
> > @@ -90,7 +90,7 @@
> >   */
> >  
> >  /* The compatible string for the KHO FDT root node. */
> > -#define KHO_FDT_COMPATIBLE "kho-v4"
> > +#define KHO_FDT_COMPATIBLE "kho-v5"
> >  
> >  /* The FDT property for the preserved memory map. */
> >  #define KHO_FDT_MEMORY_MAP_PROP_NAME "preserved-memory-map"
> > diff --git a/kernel/liveupdate/kho_block.c b/kernel/liveupdate/kho_block.c
> > index 0d2a342ef422..9b148009085e 100644
> > --- a/kernel/liveupdate/kho_block.c
> > +++ b/kernel/liveupdate/kho_block.c
> > @@ -16,6 +16,12 @@
> >   * array of serialized entries. Multiple blocks are linked together via a
> >   * physical pointer in the header, forming a linked list that can be easily
> >   * traversed in both the current and the next kernel.
> > + *
> > + * Each block header also records the size of its entries. A newer kernel may
> 
> "newer kernel" does not make sense in the documentation comment, as any 
> kernel can do that. I would suggest "outgoing kernel." 

My understanding that here "newer" kernel refers to a newer kernel version
rather than incoming or outgoing. So the docs should say something like
"different kernel versions may have different size of the entry"

> By the way, in this series you use the terms "source" and "destination"
> kernel, whereas traditionally we have used "outgoing" and "incoming."
> While both conventions work, it would be preferable to maintain
> consistency.

-- 
Sincerely yours,
Mike.

