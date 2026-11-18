Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E30B606A31C
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 01:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=AqY9hNlJ;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T01VxJ7P
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=50okuNizJHx1Ir/13AwuyhTh4ahzHtXFuIIGJ9/4RBc=; b=AqY9hNlJlMIG7X3JgjEWzZ4EIH
	px+wAwEEPcO6IssmCe2e9bSBE/x/hIf7ujOX2rUCC3Le6sXZvD/W7sIVxGzeJxq5P9tOBN9TNTJBZ
	VcVBeyJlhQKN8bXnAiAaAoDE3qXoQts2/nx1moWAa4IwQfV3ZIeOJA9NSw9dL7QFNJ8Gj95jKBcce
	jD/ZKCzCoYJCxoYDwHF5N2MCSv1tceorkzGI1cvW3ZiFPmEWNv3Q0F574c6AhtgCVYgzt+Q4aVNGy
	mONOHkGRQbmCKpso4uEaE89qkdVbPFw2QMkj9M8elM6BHuPGSsfjOQDGC307GHa7MnnbapjI0RrX1
	3UuLgygg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTUow-00000007UFP-2Yzo;
	Wed, 18 Nov 2026 01:50:46 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTUov-00000007UF4-1ur7
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 01:50:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8B13E61196;
	Wed, 18 Nov 2026 01:50:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0E31F000C4;
	Wed, 18 Nov 2026 01:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794966644;
	bh=50okuNizJHx1Ir/13AwuyhTh4ahzHtXFuIIGJ9/4RBc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T01VxJ7PLGaq7wZnRY2i9sM7xJWjWmWfLoQE0TUAjs1z8o1Br998LEakhV0WV7u+I
	 lfCgZk/h11j5tkktkipPMUoe/duMwAlvlxGdwXoByd3wjbkkvNhAnbdhfd7ySeoALQ
	 hD03ZPNS2hENguMxR/p4r0WWO7xi0V52Ae958RmjEFs8bfLmCRGsfKEUHoqc138E5L
	 ZhaVTcgeimlIXvw7j5DqLqR4tnvwANws/qOP0ZiwPRl/U9qkR14qPvdPWKUS3r3/S4
	 bgl2q0zbI1VuRvL7+ZSagSQ8PxwuS0KcGN4PnKxsKCoBMihzfiLNzW3hBhFzcsICJH
	 GEdiO9+c7tzqQ==
Message-ID: <sashiko-outbox-219914@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] riscv: kexec_file: Verify the signature of Image files
To: "Cong Wang" <xiyou.wangcong@gmail.com>, "Paul Walmsley" <pjw@kernel.org>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Baoquan He" <baoquan.he@linux.dev>, "Mike
 Rapoport" <rppt@kernel.org>
Cc: "Alexandre Ghiti" <alex@ghiti.fr>, kexec@lists.infradead.org, "Cong Wang" <cwang@multikernel.io>
In-Reply-To: <20261118013729.576325-1-xiyou.wangcong@gmail.com>
References: <20261118013729.576325-1-xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 01:50:43 +0000
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

> From: Cong Wang <cwang@multikernel.io>
>=20
> kexec_file_load() on riscv cannot check that the kernel it is given is
> trusted. KEXEC_SIG is not selectable, so a kernel that is locked down
> has to refuse kexec_file_load() altogether, and there is no way to
> restrict it to kernels signed with a trusted key.
>=20
> With CONFIG_EFI the riscv Image is a PE file, the same as on arm64, and
> can carry an Authenticode signature added by tools such as sbsign.
> Verify it with kexec_kernel_verify_pe_sig(), as arm64 does, and let
> riscv select KEXEC_SIG, KEXEC_SIG_FORCE and KEXEC_IMAGE_VERIFY_SIG.
>=20
> KEXEC_IMAGE_VERIFY_SIG is no longer specific to arm64, so drop "(ARM)"
> from its prompt.
>=20
> [ ... ]
>=20
> This is needed by multikernel, which loads its kernels with kexec_file,
> but nothing here depends on it: it applies to any kexec_file_load() user.
>=20
> Signed-off-by: Cong Wang <cwang@multikernel.io>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118013729.5763=
25-1-xiyou.wangcong@gmail.com?part=3D1


