Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309C160A2604
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 06:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=MNsQTpha;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KM9itt4L
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=JERGqFws7qn21ShXzjckTRjjEX/5sLFCO5JaN4J8wCg=; b=MNsQTphayuCEoqOSvuCwyF2Oqm
	D7YFDt3k5uNHAZ0IbzVnZEjTDzRxxW+QHzeWSkeRxQZMKAv0FgJI2Kzrgt+7Ow24KOECyD4CyABAQ
	BxtQjzachvF2eI6JhvHhnYjJZpWc5Q59EzmTYx8EFedV4jfwH+dYx0wZGry8cCOkEjYzjGCsUIuBr
	q7n/r0CE6GHLpwtM1pQH0whT2Ez0Q2LKYj56YjMZHYyJXbxp+P5Mqn6gPF/yH1p0Z9rHcRA/QEADX
	pqZMnO50R/cnOPj5LU5zMerDUhUQPO4Dpt52Y+nNIax1dfTqrZ+YzLuMqQ2DgJF+ynWdy5T0M6yKL
	TYK2h6lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR1dR-00000005j4Y-3bh4;
	Wed, 11 Nov 2026 06:16:41 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR1dQ-00000005j2t-2l4w
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 06:16:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1BC4F612BF;
	Wed, 11 Nov 2026 06:16:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD181F00A06;
	Wed, 11 Nov 2026 06:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794377799;
	bh=JERGqFws7qn21ShXzjckTRjjEX/5sLFCO5JaN4J8wCg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KM9itt4Li+SU8W4ZUm6NUV+NH2YtdQgT3L8jEt3MPeFsmYirWnAZopelOz8bCf0pG
	 iqHmWS6HgsFtY4lfE3JD4l2pJYVw6hUULXKp5CDhwbs7ZOhfCpPygc8p4KO5K8zoas
	 99HMJRArDHIopB+FH5oO56JwJhLZa27s+v24ZNo5LSY8P15evCwp0ZxExmcxPxGGAo
	 7uq/JhmST7nQc7BgHVRrAgK1UAJkuK9Rzz9fc71C36mrNYsxsoqnjWWRRQrRAuVJH6
	 a2N0EpdzBd+a5ORwmaxcKZD5QLP5VULR8QvK7Ov6tAc4qp/loTXqiL3hdxb87ru8I0
	 gQEBag1wDFS9A==
Message-ID: <sashiko-outbox-208410@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/19] kho: vmalloc: Add the feature header
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org, will@kernel.org, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, "Bjorn
 Helgaas" <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, gle.com@google.com, pbonzini@redhat.com, "Andrew
 Morton" <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: kvmarm@lists.linux.dev, linux-pci@vger.kernel.org, "Pratyush Yadav" <pratyush@kernel.org>, kexec@lists.infradead.org, kvm@vger.kernel.org, skhawaja@google.com, sagis@google.com, linux-mm@kvack.org
In-Reply-To: <20261110050202.529473-8-tarunsahu@google.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-8-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 06:16:37 +0000
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] kho: missing DECLARE_KHO_SER_HDR() kdoc transform breaks
  kernel-doc
--

commit 5eeff1f169bf967112c6cc25130cc4d0e9b8a838
Author: Tarun Sahu <tarunsahu@google.com>

kho: vmalloc: Add the feature header

This commit registers struct kho_vmalloc with the KHO serialization feature
header mechanism and updates kho_preserve_vmalloc(), kho_unpreserve_vmalloc=
(),
kho_restore_vmalloc(), and their callers to pass typed feature header
pointers.

> diff --git a/include/linux/kho/abi/memfd.h b/include/linux/kho/abi/memfd.h
> index 7b49dd6d7e2af..b0597c4389732 100644
> --- a/include/linux/kho/abi/memfd.h
> +++ b/include/linux/kho/abi/memfd.h
> @@ -80,9 +80,9 @@ static_assert(!IS_ENABLED(CONFIG_64BIT) ||
>   * @seals:     The seals present on the memfd. The seals are uABI so it =
is safe
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
>  };
> =20
>  static_assert(sizeof(struct memfd_luo_ser) =3D=3D 40);
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec=
_handover.c
> index 369ce411928d3..919210d7a91ab 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -1382,20 +1382,20 @@ static void kho_vmalloc_unpreserve_chunk(struct k=
ho_vmalloc_chunk *chunk,
>  /**
>   * kho_preserve_vmalloc - preserve memory allocated with vmalloc() acros=
s kexec
>   * @ptr: pointer to the area in vmalloc address space
> - * @preservation: placeholder for preservation metadata
> + * @fhdr:         placeholder for preservation metadata
>   *
>   * Instructs KHO to preserve the area in vmalloc address space at @ptr. =
The
>   * physical pages mapped at @ptr will be preserved and on successful ret=
urn
> - * @preservation will hold the physical address of a structure that desc=
ribes
> - * the preservation.
> + * @fhdr will hold the preservation metadata.
>   *
>   * NOTE: The memory allocated with vmalloc_node() variants cannot be rel=
iably
>   * restored on the same node
>   *
>   * Return: 0 on success, error code on failure
>   */
> -int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation)
> +int kho_preserve_vmalloc(void *ptr, DECLARE_KHO_SER_HDR(kho_vmalloc, *fh=
dr))

[Severity: Low]
Does using DECLARE_KHO_SER_HDR() here and in kho_unpreserve_vmalloc(),
kho_restore_vmalloc(), and struct memfd_luo_ser break kernel-doc without a
matching CTransforms rule in tools/lib/python/kdoc/xforms_lists.py?

In kernel/liveupdate/kexec_handover.c, KernelDoc.create_parameter_list()
replaces the comma inside DECLARE_KHO_SER_HDR(kho_vmalloc, *fhdr) with '#'
and parses the parameter name as "fhdr)", causing W=3D1 builds and make
htmldocs to warn about undescribed parameter "fhdr)" and excess parameter
"fhdr" while emitting malformed ReST c:function directives.  In
include/linux/kho/abi/memfd.h, CTokenArgs.groups() splits the outer
DECLARE_KHOSER_PTR() on the inner comma of DECLARE_KHO_SER_HDR(), truncating
the struct member in the generated documentation to
"DECLARE_KHO_SER_HDR(kho_vmalloc folios_fhdr;".

Adding (CMatch("DECLARE_KHO_SER_HDR"), r"struct kho_ser_hdr \2") to
CTransforms.struct_xforms (before DECLARE_KHOSER_PTR) and
CTransforms.function_xforms in tools/lib/python/kdoc/xforms_lists.py would
avoid both issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110050202.5294=
73-1-tarunsahu@google.com?part=3D7

