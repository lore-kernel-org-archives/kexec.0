Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886F8606A31A
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 17:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=vVUeK9/B;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mx6NUcgO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=pjiF40AAMTdxSa5q12USJ0dwiL7fQsXcz5pGqY+baug=; b=vVUeK9/BQG9MUzXJtJPZH5bba/
	LZrS8v50yIUJCWuyNSleaeyo7RFdFVcmiqwvSlRLjBIhvDFImqpPFY/O3E6ot5jBF9EYmbnyVQuTo
	o/TQoUSX5x1rEMWfvDwgttdoWay2eFO0xQvN41me6+KETVMwK9GLWLqzFM2D13ylp85ew9g0IR/bq
	AUi/LNp16Vch1Vb2/aIlc37PjV5vMVwueGU4UfIw6hbCZwmM91ql03qrwSnICmtiWRzeIlgv1wJqL
	uwi4OhsXFVanX27rTgn762oIaXYqXSaYgPydF9OAnSZW3cNzoaTvji6wRAraxVk4MnIM11e900MJp
	Wc0/+6PQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLOtS-000000031cX-13FX;
	Mon, 26 Oct 2026 17:53:58 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLOtQ-000000031as-2APa
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 17:53:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EB528400C2;
	Mon, 26 Oct 2026 17:53:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9C51F01825;
	Mon, 26 Oct 2026 17:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793037235;
	bh=pjiF40AAMTdxSa5q12USJ0dwiL7fQsXcz5pGqY+baug=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mx6NUcgONKP3ZCNoxS+5/XQIhayVCh1E+OG7xr8wuZDt1GDZmVGVM7k6POVwEnjyp
	 OmWYon0qptkrt8UGJZ18I/kBgtwt9hpgu/GGY4ZULbenmwe19G5alT8hDwUi0VMoFq
	 kdNz+5hQZPn/+oybanwUDXXi3PrnLz5jBHP3AFWCHbgVA7EMoVtGYxjB7hRJLnCbLG
	 C6in9J8CT+tD7PshYbmTcQ4VlolJ7Sh7OL4wIn9WmrO+I3EHjNvbl4IHoWtFZj2v3o
	 Z9xiOfYNz1seFNAj9lMuGqRdtl4L6K/JiNsAjwnLke6pVoKkR6skgyCmIrAxjjRbCl
	 TrSJK8lABchlw==
Message-ID: <sashiko-outbox-185600@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 3/4] mm: memfd_luo: Add the feature header
To: "Tarun Sahu" <tarunsahu@google.com>, loganodell@google.com, alex@shazbot.org, dwmw2@infradead.org, seanjc@google.com, "Mike
 Rapoport" <rppt@kernel.org>, will@kernel.org, pbonzini@redhat.com, jgg@nvidia.com, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, arnd@arndb.de, "Andrew Morton" <akpm@linux-foundation.org>, oupton@kernel.org, baolu.lu@linux.intel.com, "David
 Matlack" <dmatlack@google.com>, robin.murphy@arm.com, maz@kernel.org, "Alexander
 Graf" <graf@amazon.com>, joro@8bytes.org, "Bjorn Helgaas" <bhelgaas@google.com>, kevin.tian@intel.com, "Pratyush
 Yadav" <pratyush@kernel.org>
Cc: kexec@lists.infradead.org
In-Reply-To: <20261026174217.603114-4-tarunsahu@google.com>
References: <20261026174217.603114-1-tarunsahu@google.com>
 <20261026174217.603114-4-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 17:53:54 +0000
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> Precede struct memfd_luo_ser with the 8-byte struct luo_ser_hdr for
> memfd preservation. The source kernel writes the state through struct
> memfd_luo_ser_wrap, declared with DECLARE_LUO_SER_WRAP():
>=20
>   DECLARE_LUO_SER_WRAP(memfd_luo_ser, 64, MEMFD_LUO_FEAT_MAX);
>=20
> This consists of hdr + memfd_luo_ser (payload).
>=20
> The existing struct memfd_luo_ser fields (pos, size, seals, flags,
> nr_folios, folios, and MEMFD_LUO_ALL_SEALS) form MEMFD_LUO_FEAT_CORE
> (index 0 of enum memfd_luo_feature). The source kernel marks it as
> LUO_FEAT_REQUIRED when preserving state, and the target kernel marks it
> as supported (true) in its memfd_luo_supported_feats table passed to
> luo_ser_hdr_validate(). Future changes append any new fields to the end
> of struct memfd_luo_ser under a new feature index so existing field
> offsets never shift.
>=20
> memfd_luo_retrieve() and memfd_luo_finish() validate the incoming header
> against memfd_luo_supported_feats with luo_ser_hdr_validate() before
> accessing any payload field; finish warns and skips discarding the folios
> when the header is invalid.
>=20
> Prepending the header shifts every field of the serialized memfd state,
> so bump MEMFD_LUO_FH_COMPATIBLE from memfd-v2 to memfd-v3.
>=20
> Signed-off-by: Logan Odell <loganodell@google.com>
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026174217.6031=
14-1-tarunsahu@google.com?part=3D3


