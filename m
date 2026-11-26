Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A05606A321
	for <kexec@archiver.kernel.org>; Thu, 26 Nov 2026 18:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=i9G3Oowh;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n2CNBE5+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=OJrIBssRihwY1hjT7BcClChtfC90/g3C4v7S4XKqBtA=; b=i9G3Oowh7X6v2eJcGHMaysEVe8
	EeUZdncwCfdpN5LwQCfbjHyop+ag0qg1746v/twPBnieQsiWRENmEHqqmta44vdpt3aIyN02nG14x
	x9jaMYaBoED2ZTzLXfPRxNtSkHSP0jj8I3pfkaJvkXKwtTFo/SdTfgpGZSWIAxW6OGX+hhOMq1rMj
	OQjvBdFAB+96tlqaPz/+sg5QyW4BBOdqAjYl1pQxJASUnwwbLfwWgPckUoKjFVgIWZRYgdDaii7RF
	ODbHDeLkhjrqL9C/DGxmLE1vnsM0BVtymf2khf61lht5rSSsnhi0r4nR3YxeSpj86qKqv9dNeXiUE
	L/qZj5mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWeXF-0000000ECUv-41UG;
	Thu, 26 Nov 2026 18:49:33 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWeXE-0000000ECUk-3spq;
	Thu, 26 Nov 2026 18:49:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0DA8760A54;
	Thu, 26 Nov 2026 18:49:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5161F000C0;
	Thu, 26 Nov 2026 18:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795718971;
	bh=OJrIBssRihwY1hjT7BcClChtfC90/g3C4v7S4XKqBtA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=n2CNBE5+M6S3Gti+E4h/BEiW+QZsCLWVg3Z07JmCFD4CJWtQOT7wmTFvMHay90J17
	 FASidj/Tb9qKR6r+t0f8m5l2GSXoRaCyDUjouiMfYBDRAya375OAB8ifBdjby0L3cN
	 XvZu0xkJxI/+pA9AAyI7y3aIotV8xSxGc2csYUvuvg6Uw1JsXVX+0NOYxmoIoYXxv2
	 M34fX1uPVfxBkS9zufumLpfpKWYxQRuFEpxczh1v12sNbqWWyTovgyCerZ8wJElZbL
	 qHPbpDy15BB/FUoYPImERW6CSIHqZ46EBBEwU+aASP6SbeqtKq5FQihbH4FEKfQfVt
	 VyCXs6QVLSDTA==
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
Subject: Re: [PATCH v4 18/19] mm: memfd_luo: Add feature header to struct
 memfd_luo_folio_ser
In-Reply-To: <20261110050202.529473-19-tarunsahu@google.com> (Tarun Sahu's
	message of "Tue, 10 Nov 2026 05:02:01 +0000")
References: <20261110050202.529473-1-tarunsahu@google.com>
	<20261110050202.529473-19-tarunsahu@google.com>
Date: Thu, 26 Nov 2026 18:49:24 +0000
Message-ID: <2vxz8q2fwhqj.fsf@kernel.org>
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10 2026, Tarun Sahu wrote:

> Precede each serialized folio entry in the preserved memfd folio array
> with struct kho_ser_hdr via DECLARE_KHO_SER so future per-folio memfd
> features can append fields to struct memfd_luo_folio_ser without breaking
> compatibility between adjacent kernels.
>
> Allocate the preserved folio array using kho_ser_size(memfd_luo_folio_ser)
> per entry and initialize each entry feature header in
> memfd_luo_preserve_folios(). On the incoming path in
> memfd_luo_discard_folios() and memfd_luo_retrieve_folios(), validate each
> entry feature header with kho_ser_validate() and advance between entries
> using fhdr->size so entries written with a different feature layout are
> traversed accurately.

No. The flags in each folio entry is a part of memfd's ABI. These flags
don't have an ABI of their own. If the layout of memfd_luo_folio_ser
changes, it goes in the memfd_luo_ser flags.

Doubling the memory needed to preserve a memfd is not acceptable.

[...]

-- 
Regards,
Pratyush Yadav

