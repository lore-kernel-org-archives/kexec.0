Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45719606A33B
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 06:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FzULbizw;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OArMx+t8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=fscXIP2li/I0NRYzz1oi4vQZQC1ldclu1W8hz2ayPZM=; b=FzULbizwd6ksCGMRWHktxWwJ15
	C4Eu2yBKZPjcpDFTATbd2IIFXqIWwfLyinugUS6apBzP3SXxtSMrba1xwuKJZvnLXKOaNR1UaO+h3
	0LMK+pXVPkP+QYvQLqdYoeV9yWR8xkPfpbgpd8+lbFqE6qhkftYIdaDLsIM+rpWX4FGF8/6yXziiT
	58oBJ7xvgk7hcCisbTpqHpzIED3Fq1tQIUB+Am8jFgtR1sX/WSEsNJXfoG6Tdo1/EbSXeDm8AZpGr
	6daFPPvIQLWS8rYu52p6UzXl5a+HfMgy+XV2/KQXBdXkQxS+Ox9PmTMJAmIeD855K7nO18R50lmZH
	SkfVfLfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR1dU-00000005j7x-461q;
	Wed, 11 Nov 2026 06:16:44 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR1dS-00000005j4f-1CJ7
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 06:16:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BEFC645AD9;
	Wed, 11 Nov 2026 06:16:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3621F00A06;
	Wed, 11 Nov 2026 06:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794377801;
	bh=fscXIP2li/I0NRYzz1oi4vQZQC1ldclu1W8hz2ayPZM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OArMx+t8JccceqnmvhU8sc6QFtIfmaCVldSfP6Y/co0u6nZzbEAwSYMrHdIqGuhiR
	 Ygi7CsqEgyE/v3uqMYgJ7hNlWG0fErD/UHsSU/WEH8JpofK3/5G+mFvMQ4Z+wTi1jL
	 syEORqaGNydjbql0uOpp9w3allnnjaYYeZMnrs5IRVxLT/u8XrHkP0rZL8UVvWDMXT
	 3j+9eNVtco746JUidsgVUGDFyu4rrVoiO4OxdjPDPKvvnTCCEjIODem5aOS84JFH1u
	 ltbzVdzhbbsskPFTy44U0XzR42rNVCKuliar2uI8IMjzqrxA0TSpZvVSKQ1oNTPqz3
	 tGmNATGDTbZdA==
Message-ID: <sashiko-outbox-208411@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/19] kho: block: Add the feature header to blocks
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org, will@kernel.org, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, "Bjorn
 Helgaas" <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, gle.com@google.com, pbonzini@redhat.com, "Andrew
 Morton" <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: linux-pci@vger.kernel.org, "Pratyush Yadav" <pratyush@kernel.org>, kexec@lists.infradead.org, skhawaja@google.com, sagis@google.com
In-Reply-To: <20261110050202.529473-9-tarunsahu@google.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-9-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 06:16:39 +0000
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> Subsystems using the KHO Serialization Blocks framework currently rely
> on whole-structure compatibility strings to validate serialized block
> sets across kexec. Any modification to the block structure layout
> constitutes a breaking change and breaks compatibility between adjacent
> kernels.
>=20
> Precede struct kho_block_header_ser with struct kho_ser_hdr using
> DECLARE_KHO_SER. Each block in a block set starts with struct
> kho_ser_hdr followed by struct kho_block_header_ser. Serialized entries
> start immediately after the header payload at offset fhdr->size.
> Block capacity is computed as (KHO_BLOCK_SIZE - fhdr->size) /
> bs->entry_size. Subsystems can append future block-level metadata under
> new feature indices without altering existing offsets.
>=20
> On restore, the location of the first entry and the block capacity no
> longer depend on the caller. They are derived from the header size and
> entry size the source kernel serialized with, even if the target kernel
> structures have a different size. Fields that the source kernel did not
> serialize are absent: a subsystem must not access them unless the
> corresponding feature is present in the incoming header, as doing so
> reads memory outside the serialized data.
>=20
> During restoration, blocks whose header does not fit the block are
> rejected, and the chain walk stops at such a block. Validate each block
> header and reject unknown required features.
>=20
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110050202.5294=
73-1-tarunsahu@google.com?part=3D8


