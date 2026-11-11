Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6161D60A2608
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 06:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WcIdscnM;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MbNXobAQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=0CG1UcJOAjSNTO8JIN0pN5xZ098zwfCHiKYXyozJu5g=; b=WcIdscnMxOeGF4a+Aeu249R62e
	Dd3GuiTYoiAzg9hEtOWhFpTVMzZ4K3B34JfR+YaHbJ5UYW1T+bep/88cjim/o59trcgFCjXMpQF9R
	nsi0/plqdWqF0Gjk0bjhWNX/ECrWanIaoTeaaEHPQfVx81/kGmJTctcvsFGgcMEsJ8dpzKKLUbQxP
	XJvvc/jS3fPbBlmVgUDY2IAEOmg3Jzcvh2/kSzrIrNXLKLM4D8R9/QGYer6j8X3SFw9E3hf4qUx9P
	CUB/UTwG5OzCb178bueRPsUL6B4Yaga7bNVTlESLox14g4PdbUhy06OyLi3lfW1AyyiTv7F8eX7/K
	/hjxuKYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR1dl-00000005jS8-0Dza;
	Wed, 11 Nov 2026 06:17:01 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR1dj-00000005jQA-3k1n
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 06:16:59 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9EDDA44D64;
	Wed, 11 Nov 2026 06:16:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 215CD1F00A05;
	Wed, 11 Nov 2026 06:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794377819;
	bh=0CG1UcJOAjSNTO8JIN0pN5xZ098zwfCHiKYXyozJu5g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MbNXobAQp8xUF/BBqw0Es8S0zNZqgPpsP8tSno3whHxWT+eG/GJdAXRflVIdGyAKb
	 TfsZkz+mzhAgqkksMKP8UwAl6jQyxasiCBrTlL6LOV7UVW0MxW2KT0LtffLtBCtU5k
	 KwQTpERdezry2cljcogaGSA8gWqU2BRUOschZo8q5gNjz5FKq731YnejwrxtrzDjrI
	 Adj6uwLe/JvRxCEEQUvvB0yhiZbtLhpM9ajpet7kB1P2xZmjCob5z/COmv1IDGKRTo
	 6k1hrtDHqhtipPQWp771Pk1tPIi/U4O2LWEO/ArfmJ7qEZrWuu+hnCJ6TZCaoAhXfD
	 C5n0O4pSW+0wQ==
Message-ID: <sashiko-outbox-208421@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 18/19] mm: memfd_luo: Add feature header to struct
 memfd_luo_folio_ser
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org, will@kernel.org, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, "Bjorn
 Helgaas" <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, gle.com@google.com, pbonzini@redhat.com, "Andrew
 Morton" <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: kvmarm@lists.linux.dev, linux-pci@vger.kernel.org, "Pratyush Yadav" <pratyush@kernel.org>, kexec@lists.infradead.org, kvm@vger.kernel.org, skhawaja@google.com, sagis@google.com, linux-mm@kvack.org
In-Reply-To: <20261110050202.529473-19-tarunsahu@google.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-19-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 06:16:57 +0000
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
- [Medium] mm: memfd_luo: folio leak on kho_ser_validate() failure in
  retrieve/discard
--

commit c3d8dd278c3f1e63ea2c973472e060bae843ec49
Author: Tarun Sahu <tarunsahu@google.com>

mm: memfd_luo: Add feature header to struct memfd_luo_folio_ser

This commit adds a struct kho_ser_hdr feature header to each serialized
memfd folio entry and validates it during retrieve and discard.

> diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
> index 94510f73a6069..c00daa8a508e1 100644
> --- a/mm/memfd_luo.c
> +++ b/mm/memfd_luo.c

[ ... ]

> @@ -384,16 +391,23 @@ static void memfd_luo_unpreserve(struct liveupdate_=
file_op_args *args)
>  	inode_unlock(inode);
>  }
> =20
> -static void memfd_luo_discard_folios(const struct memfd_luo_folio_ser *f=
olios_ser,
> +static void memfd_luo_discard_folios(const DECLARE_KHO_SER_HDR(memfd_luo=
_folio_ser, *folios_ser),
>  				     u64 nr_folios)
>  {
> +	const DECLARE_KHO_SER_HDR(memfd_luo_folio_ser, *fhdr) =3D folios_ser;
>  	u64 i;
> =20
> -	for (i =3D 0; i < nr_folios; i++) {
> -		const struct memfd_luo_folio_ser *pfolio =3D &folios_ser[i];
> +	for (i =3D 0; i < nr_folios; i++, fhdr =3D (const void *)fhdr + fhdr->s=
ize) {
> +		const struct memfd_luo_folio_ser *pfolio;
>  		struct folio *folio;
>  		phys_addr_t phys;
> =20
> +		if (kho_ser_validate(fhdr, memfd_luo_folio_ser)) {
> +			pr_warn("invalid folio feature header, folios not discarded\n");
> +			return;
> +		}
> +
> +		pfolio =3D kho_ser_payload(fhdr, memfd_luo_folio_ser);
>  		if (!pfolio->pfn)
>  			continue;

[ ... ]

> @@ -447,9 +461,10 @@ static void memfd_luo_finish(struct liveupdate_file_=
op_args *args)
>  }
> =20
>  static int memfd_luo_retrieve_folios(struct file *file,
> -				     struct memfd_luo_folio_ser *folios_ser,
> +				     const DECLARE_KHO_SER_HDR(memfd_luo_folio_ser, *folios_ser),
>  				     u64 nr_folios)
>  {
> +	const DECLARE_KHO_SER_HDR(memfd_luo_folio_ser, *fhdr) =3D folios_ser;
>  	struct inode *inode =3D file_inode(file);
>  	struct address_space *mapping =3D inode->i_mapping;
>  	struct folio *folio;
> @@ -457,12 +472,20 @@ static int memfd_luo_retrieve_folios(struct file *f=
ile,
>  	int err =3D -EIO;
>  	long i;
> =20
> -	for (i =3D 0; i < nr_folios; i++) {
> -		const struct memfd_luo_folio_ser *pfolio =3D &folios_ser[i];
> +	for (i =3D 0; i < nr_folios; i++, fhdr =3D (const void *)fhdr + fhdr->s=
ize) {
> +		const struct memfd_luo_folio_ser *pfolio;
>  		phys_addr_t phys;
>  		u64 index;
>  		int flags;
> =20
> +		err =3D kho_ser_validate(fhdr, memfd_luo_folio_ser);
> +		if (err) {
> +			pr_err("memfd_luo_folio_ser feature validation failed: %pe\n",
> +			       ERR_PTR(err));
> +			goto put_folios;
> +		}
> +
> +		pfolio =3D kho_ser_payload(fhdr, memfd_luo_folio_ser);
>  		if (!pfolio->pfn)
>  			continue;
> =20
> @@ -472,7 +495,7 @@ static int memfd_luo_retrieve_folios(struct file *fil=
e,
>  			pr_err("Unable to restore folio at physical address: %llx\n",
>  			       phys);
>  			err =3D -EIO;
> -			goto put_folios;
> +			goto next_put_folios;
>  		}
>  		index =3D pfolio->index;
>  		flags =3D pfolio->flags;
> @@ -524,15 +547,22 @@ static int memfd_luo_retrieve_folios(struct file *f=
ile,
>  unlock_folio:
>  	folio_unlock(folio);
>  	folio_put(folio);
> +next_put_folios:
> +	i++;
> +	fhdr =3D (const void *)fhdr + fhdr->size;
>  put_folios:
>  	/*
>  	 * Note: don't free the folios already added to the file. They will be
>  	 * freed when the file is freed. Free the ones not added yet here.
>  	 */
> -	for (long j =3D i + 1; j < nr_folios; j++) {
> -		const struct memfd_luo_folio_ser *pfolio =3D &folios_ser[j];
> +	for (; i < nr_folios; i++, fhdr =3D (const void *)fhdr + fhdr->size) {
> +		const struct memfd_luo_folio_ser *pfolio;
>  		phys_addr_t phys;
> =20
> +		if (kho_ser_validate(fhdr, memfd_luo_folio_ser))
> +			break;
> +
> +		pfolio =3D kho_ser_payload(fhdr, memfd_luo_folio_ser);
>  		if (!pfolio->pfn)
>  			continue;

[Severity: Medium]
Does this leak the remaining preserved folios when kho_ser_validate()
fails?

When kho_ser_validate() fails on entry i in memfd_luo_retrieve_folios(),
it jumps to put_folios with fhdr still pointing at entry i.  The cleanup
loop then calls kho_ser_validate(fhdr, memfd_luo_folio_ser) on that same
entry and immediately breaks, leaving entry i and all subsequent entries
un-restored and permanently leaked.

Similarly, memfd_luo_discard_folios() returns on the first validation
failure instead of continuing or still restoring pfolio->pfn across the
array using fhdr->size, which only checks for unknown required feature
bits while the base payload and entry stride remain valid.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110050202.5294=
73-1-tarunsahu@google.com?part=3D18

