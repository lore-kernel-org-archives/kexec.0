Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE18606A31F
	for <kexec@archiver.kernel.org>; Thu, 22 Oct 2026 15:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=SllEucFW;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KG/ahhDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ShNiCMk8Kuf8pc2qB+tQRe+Fq75YJp+jO77Paj5vAT8=; b=SllEucFWAQsN1F57DZlVWefhr1
	DugFVx4tB8fN95WKXPiYy8fyreyNczuJC2FAgjKl+S/eyLozuLUfqY99pyjFccYMx/TmHq7p8z4hG
	a548hXjaY8xZORcl/B2CWiEScScW5EX68d25jawaZpFOmoZkd5avUzKMIgDPJ77xooWBBBsDhyKyP
	AXaJqt5bwAw5GVdi4UUlRaBF6YqWqgv/peFCG2IgqEEJU1iMbQxDnV5N4h5+xNe5GzzJYAUsmO6Pc
	IPB5yWvm7lVns2M6Fr6+mOJxGmgZ4u8Tuwzj553SbDzFQuVMvXYngD0VGkKOlP1Ykti20KNpm6H4K
	L/Koxq1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJugW-0000000EPER-3xa9;
	Thu, 22 Oct 2026 15:26:28 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJugR-0000000EPDP-0ViS
	for kexec@lists.infradead.org;
	Thu, 22 Oct 2026 15:26:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8E96D62CC2;
	Thu, 22 Oct 2026 15:26:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB2E1F01828;
	Thu, 22 Oct 2026 15:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792682782;
	bh=ShNiCMk8Kuf8pc2qB+tQRe+Fq75YJp+jO77Paj5vAT8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KG/ahhDTlLfdPHHLRIXec/17R576tWHUPWqYwwZtqRAkH9gmk96VkUbys9bFRitIz
	 hb+W/lY6cQNa2FAKkCQTHppIq0ErCF6chSi8acEObQHS8drrpFbsvrr0T8tmBToh6l
	 +6faJfTY035e2rxW5JZGK+e0/5k1yYr3wObGkLqjPPQPcWqcinYVLyGsnLA624OYnr
	 xvnoPipWUv+m2tGCZEG/J6jzXmcUwmnfL6sTfoRDtoQZvnvXtOHUdTDK9qviFpTFRs
	 FHsqYRElnShhy52IA7WsxqAWEsy/e4NP2E7YRUuUloiPNvuaeXIbrk5q1G8UZOXbbi
	 lyuq0A5swftPg==
Message-ID: <sashiko-outbox-181698@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 4/4] mm: memfd_luo: Add the 2-bit pair feature
 header
To: "Tarun Sahu" <tarunsahu@google.com>, "Andrew Morton" <akpm@linux-foundation.org>, joro@8bytes.org, "Mike
 Rapoport" <rppt@kernel.org>, "Pratyush Yadav" <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de, "David
 Matlack" <dmatlack@google.com>, jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com, oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org, dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, will@kernel.org, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Alexander Graf" <graf@amazon.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, baolu.lu@linux.intel.com
Cc: sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, skhawaja@google.com, kvm@vger.kernel.org
In-Reply-To: <20261021152527.375070-5-tarunsahu@google.com>
References: <20261021152527.375070-1-tarunsahu@google.com>
 <20261021152527.375070-5-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 15:26:21 +0000
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
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mm: memfd_luo: missing feature header validation in memfd_luo_fi=
nish()
--

commit b960724786ac11078fdfa9ded6bcd2355170cf0b
Author: Tarun Sahu <tarunsahu@google.com>

mm: memfd_luo: Add the 2-bit pair feature header

This commit embeds a 128-byte struct luo_feature_hdr at the start of struct
memfd_luo_ser and defines enum memfd_luo_feature with MEMFD_LUO_FEAT_CORE as
a required feature. It initializes the feature header during
memfd_luo_preserve() and validates it during memfd_luo_retrieve().

> diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
> index 64f8b8cb75bdb..ea1f4c8cd2591 100644
> --- a/mm/memfd_luo.c
> +++ b/mm/memfd_luo.c

[ ... ]

> @@ -525,6 +531,14 @@ static int memfd_luo_retrieve(struct liveupdate_file=
_op_args *args)
>  	if (!ser)
>  		return -EINVAL;
> =20
> +	err =3D luo_feature_hdr_validate(&ser->features, memfd_luo_features);
> +	if (err) {
> +		pr_err("memfd_luo_ser feature header validation failed (size=3D%llu, f=
lags[0]=3D%#llx): %pe\n",
> +		       ser->features.size, ser->features.flags[0],
> +		       ERR_PTR(err));
> +		goto free_ser;
> +	}
> +
>  	/* Make sure the file only has seals supported by this version. */
>  	if (ser->seals & ~MEMFD_LUO_ALL_SEALS) {
>  		err =3D -EOPNOTSUPP;

[Severity: Medium]
Here in memfd_luo_retrieve(), ser->features is validated via
luo_feature_hdr_validate() before accessing any MEMFD_LUO_FEAT_CORE fields,
jumping directly to kho_restore_free(ser) on failure.

However, when a preserved memfd is not retrieved in the target kernel before
the session is finished or closed (for example via luo_session_release() ->
luo_session_finish_one() -> luo_file_finish() -> luo_file_finish_one() ->
memfd_luo_finish() with args->retrieve_status =3D=3D 0), memfd_luo_finish()
reads ser->nr_folios and ser->folios without validating ser->features first:

mm/memfd_luo.c:memfd_luo_finish() {
	if (args->retrieve_status)
		return;

	ser =3D phys_to_virt(args->serialized_data);
	if (!ser)
		return;

	if (ser->nr_folios) {
		folios_ser =3D kho_restore_vmalloc(&ser->folios);
		if (!folios_ser)
			goto out;

		memfd_luo_discard_folios(folios_ser, ser->nr_folios);
		vfree(folios_ser);
	}

out:
	kho_restore_free(ser);
}

According to the ABI contract in include/linux/kho/abi/memfd.h, fields of a
LUO_FEAT_REQUIRED feature such as nr_folios and folios are only guaranteed
present once luo_feature_hdr_validate() succeeds.

Should memfd_luo_finish() also call luo_feature_hdr_validate(&ser->features,
memfd_luo_features) and skip to kho_restore_free(ser) if validation fails,
so it does not pass unvalidated MEMFD_LUO_FEAT_CORE fields to
kho_restore_vmalloc() and memfd_luo_discard_folios()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021152527.3750=
70-1-tarunsahu@google.com?part=3D4

