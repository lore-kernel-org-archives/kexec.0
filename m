Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8295F606A327
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 07:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=v8UGHdlO;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iodlfHDC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=910x1IuBYQ08cw28ysRzI6ykOIcJmcHsBHrRO5jnQrU=; b=v8UGHdlO/BRa1uNU/728RQtswA
	Q6XDn5hB9IBVGdL7wCxLGOZ5CTXyoLCJhZkbTiwV1ytUZy9wX47fBJ9udcZ98A/qBQk/+klCjHexc
	ylmJoFX35cdWYB9BWMqe+/ltTPeerQ7wAeyn9rnHO61zkUaKOrvuvRe1LK2FWO+hh+OJ5vYRfCyB0
	MchYgOZngg/IhkuexLaok0u2XYqdmgrqXCtxrinF1WBx5xcbD36dqfWoYZtDaUNXm+eyX7OcAzEgl
	I0g37943qzcupVptk30CThaX6Us39Lu9+xVJVBugoDlwS9C+B3Z4p8YHT6mWzmmNGBtRjvAcoq6Qz
	VHWoO5eA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNmcZ-0000000FlpS-3G97;
	Mon, 02 Nov 2026 07:38:23 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNmcY-0000000FlpJ-3bcT
	for kexec@lists.infradead.org;
	Mon, 02 Nov 2026 07:38:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5052D435AF;
	Mon,  2 Nov 2026 07:38:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7251F000C1;
	Mon,  2 Nov 2026 07:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793605102;
	bh=910x1IuBYQ08cw28ysRzI6ykOIcJmcHsBHrRO5jnQrU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iodlfHDC8q6iO78JkbesziZE0wSccGh3J2fvzqEfbS5Tc7CcjBVwo2pXPtByW1FVk
	 RMbUgoeQUL4s1i1YG8mEVi92RrD/yJk3gjzihZ1o7y3t/u2lYqdpg2oKCZM4DpIIF3
	 CW+OpguysEYu4VlYarX0byoKkqWRPYQ00Yl1mvNbFhyYa6o0eigzmUuuFgc1v+TqVm
	 6pKc21Px0AWTFX8GtdcdPfpFUWTCRNK99+RuyvAAUs9AcG7NQ9FfY8gxu2vdJ5jkUm
	 rXL0b5/wmbF7A4gt92gh94YhxgsCz18SXDVHvIfAfPs7h5IG34438a2D3oKU9CIArl
	 8czNT2OkQqvPQ==
Message-ID: <sashiko-outbox-193032@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next] crypto: asymmetric_keys: verify_pefile: fix
 integer underflow in pefile_strip_sig_wrapper
To: "Gu Bowen" <gubowen5@huawei.com>, "David Howells" <dhowells@redhat.com>, "Lukas
 Wunner" <lukas@wunner.de>, "Ignat Korchagin" <ignat@linux.win>, "Herbert Xu" <herbert@gondor.apana.org.au>
Cc: kexec@lists.infradead.org, lujialin4@huawei.com
In-Reply-To: <20261102074934.2925339-1-gubowen5@huawei.com>
References: <20261102074934.2925339-1-gubowen5@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 07:38:21 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102074934.2925=
339-1-gubowen5@huawei.com?part=3D1


