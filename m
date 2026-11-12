Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB1E606A323
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 13:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=IMyR7e/S;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HfnNv/WL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=IzbLrr7LpII86auCWYhAT6Y6p+u1NQD5p3z/oEoSjdk=; b=IMyR7e/SOsRi66kDoYYwW9eNZF
	1/yEfGrSXRqLYiQaAH/8OHqRWq5SPn/ou5rEkDuRpZyhIVz58DP2OuYsOVDd4+oRq6jzogq9UpaOq
	1G1wIqK1t6261yx8+VixuQHNX7M7tmnEZm7gmrr+J8xhMftUhQxC3BcGBukdkAUim/gOl9bceqzao
	tMn75mkvJhzKjP7QSlz6kqS9wdlE9kPPxBgfNy/l2QRlUCdoC9kQt2FRTUDjGK2NIoRSrtGNSVQtW
	uq7M6mrsLKNE919AdMUr54r0SbF5cSBCstjh+UKbuqUqW/pI6iTkQH8ZE6Jspilh+T6BbqE0Hfha9
	8VyIJdMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRUWR-00000009y1o-3k8u;
	Thu, 12 Nov 2026 13:07:23 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRUWH-00000009xzg-3qTN
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 13:07:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 467A441B73;
	Thu, 12 Nov 2026 13:07:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B81F91F00A05;
	Thu, 12 Nov 2026 13:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794488833;
	bh=IzbLrr7LpII86auCWYhAT6Y6p+u1NQD5p3z/oEoSjdk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HfnNv/WLp+DcMOfcuEHEHMATGGLebAUYiMpEZobW4NtyqVg0B80WjPbBqvAnFh/1b
	 41RN708d47oBtuV3ft2S9/DP117mqkrTaps52VSR0bP/B1aR0L0A52q7qGive+lyEj
	 Ituj9mcSUdMn18XEA9VcUmWn44TtvFcar/AVpSMM5RufX/YsLU0ijBKJZmtY38e7ib
	 oyC4DwC9V7NzKgZGxS6VR0Cd44+UGNs+YQzXuKjMZJG9O/zKLU7PgbgOnAdXra1Ec+
	 btHaEimtgxADC05Zzsu9DogiqrKLy/sVJrsBkZjEInI2D5+QheHwqlnVsrGwo5D2Ql
	 /Qi9XBWiImwAQ==
Message-ID: <sashiko-outbox-211138@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] ima: keep kexec dump state tied to installed
 image
To: =?utf-8?b?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Baoquan He" <baoquan.he@linux.dev>, "Mike
 Rapoport" <rppt@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Mimi Zohar" <zohar@linux.ibm.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>
Cc: "Eric Snowberg" <eric.snowberg@oracle.com>, linux-security-module@vger.kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261112125246.2715174-4-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261112125246.2715174-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <20261112125246.2715174-4-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 13:07:12 +0000
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

> ima_add_kexec_buffer() updates the global measurement scratch buffer
> and segment size for the new image. If kexec_file_load() fails, the
> new image is freed but the scratch buffer and segment size remain. When
> kexec starts the installed image, ima_update_kexec_buffer() dumps the
> measurement list into the IMA segment. A larger failed segment causes an
> OOB write, while a smaller one truncates the log and reports the wrong
> size in the kexec_execute event. KASAN for instsance reports the OOB
> writes as:
>=20
>   BUG: KASAN: vmalloc-out-of-bounds in ima_update_kexec_buffer+0x265/0x280
>   Write of size 868426 at addr ffffc9000004e000 by task init/1
>   ...
>   __asan_memcpy+0x3b/0x60
>   ima_update_kexec_buffer+0x265/0x280
>=20
> Leave installed scratch state unchanged until all later load steps pass.
> Store new buffers in the candidate and reuse only equal-size installed
> buffers. Emit kexec_load before those steps with the local size.
> Allocation failure still omits the optional segment.
>=20
> Fixes: 9f0ec4b16f2b ("ima: kexec: move IMA log copy from kexec load to ex=
ecute")
> Cc: stable@vger.kernel.org
> Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112125246.2715=
174-2-Jeremy.Jean@oss.cyber.gouv.fr?part=3D2


