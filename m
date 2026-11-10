Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AF3606A336
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 01:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ebhpdMtp;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C9ATT+bv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=4dd01jOLK6qsVB7gjt33VfmWj3cugIVLlzJb8QKyBA0=; b=ebhpdMtp+4iZRUg1NABYxCWjIh
	6kBoR7VcgWFePFra00VOf/fxn1l6x3jh43EFiV0tkuOw2wQHMcWNqotAL7stJxsv9TFjO17lPUztC
	iy63DxG3hUOBMIPka+NfWQvkhY5FHH2OPqa7teGJ6W/vinkoh5vMuESmcsHVbD6Kdzx1HENmPTA2x
	E3Ub1jxFt3RGpOMZ+GnFjkAaxpM25dGIEmiInr4Um1fxwwWPc4y/81H9iPKV1+qC9Tvl8RZK8uGlM
	mCorz4GRcdz299fxsZudc4kPLYeErlOA+Pj8ffk0zajbdQYcVp1zLz1fsPHq4AmA7vQcPclzXlTGL
	B0YgbHwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQazR-000000027NA-3K7R;
	Tue, 10 Nov 2026 01:49:37 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQazQ-000000027N2-1cnp
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 01:49:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B13EF45617;
	Tue, 10 Nov 2026 01:49:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467141F008A3;
	Tue, 10 Nov 2026 01:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794275375;
	bh=4dd01jOLK6qsVB7gjt33VfmWj3cugIVLlzJb8QKyBA0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C9ATT+bvEbBdz2CCuSS4jMUou6D6uGAKiYV129HK+k1MWA11G8WwSZidBXCPyVLjH
	 hRsKYW+74g7coZnWFTnwhsvs+jCHCk3af44tGjVhl0u4iWzI7wHaGgHrzLMLeu4PXc
	 8OS2INwaCGHd7Sf9Pi8GQkq3H8wcEC9sfw+jRjJwL2iL4aYDiRbrbEv+/3WBporTlb
	 +Kria0taYr73KG+LsOeBP1K4hA0o4R4MmC0QPLkp+VvYznO15JyMn6bsEIeUfTuhT9
	 +rSBzd1NhpusIUFpEJMRnB9MxJ5MDTWgkHn0Bs5d3N5Fw+wzvitXwoA/GiWwbKLChw
	 m7W7RY+5tGa8w==
Message-ID: <sashiko-outbox-205990@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] crypto: asymmetric_keys: verify_pefile: fix integer
 underflow in pefile_strip_sig_wrapper
To: "Gu Bowen" <gubowen5@huawei.com>, "David Howells" <dhowells@redhat.com>, "Lukas
 Wunner" <lukas@wunner.de>, "Ignat Korchagin" <ignat@linux.win>, "Herbert Xu" <herbert@gondor.apana.org.au>
Cc: kexec@lists.infradead.org, lujialin4@huawei.com
In-Reply-To: <20261110015657.528337-1-gubowen5@huawei.com>
References: <20261110015657.528337-1-gubowen5@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 01:49:34 +0000
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

> The pefile_strip_sig_wrapper() function validates the win_certificate
> wrapper that precedes the PKCS#7 signature in a PE binary.  It checks
> that the wrapper length does not exceed the certificate table size
> (``wrapper.length > ctx->sig_len``) but fails to verify that the
> wrapper length is at least ``sizeof(struct win_certificate)`` (8 bytes).
>=20
> When a crafted PE image supplies a wrapper with ``length`` in the range
> [1, 7], the subsequent arithmetic::
>=20
>     ctx->sig_len =3D wrapper.length;      /* e.g. 1 */
>     ctx->sig_offset +=3D sizeof(wrapper);
>     ctx->sig_len -=3D sizeof(wrapper);    /* 1 - 8 =3D 0xFFFFFFF9 (unsign=
ed) */
>=20
> underflows the unsigned ``ctx->sig_len`` to a value near UINT_MAX.  The
> following ``sig_len < 4`` sanity check is bypassed because 0xFFFFFFF9 is
> [ ... ]
> prevent the underflow.
>=20
> Fixes: 09dacbbda935 ("pefile: Strip the wrapper off of the cert data bloc=
k")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gu Bowen <gubowen5@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110015657.5283=
37-1-gubowen5@huawei.com?part=3D1


