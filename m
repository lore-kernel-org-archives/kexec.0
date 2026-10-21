Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768D8606A319
	for <kexec@archiver.kernel.org>; Wed, 21 Oct 2026 21:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=CwN5WQV7;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GbszFmmE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:Reply-To:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date
	:Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8SOYeN3mI9h0Q5+F0MQ98iCiGI8n0ATb68xRMfgn+1Q=; b=CwN5WQV7uA+RyBsSlVA4N/Fcj6
	IwGX/3sQK4xg29RwrMu0pKzsbfIhLF9zDNg4WrvjycD1GLUwA39fmgI+TNzkuJmYZbFq+TKk1MlT2
	cxbYi0tSp4DpZGQxTKwh58Iy+/Otn53KXXhGAyD6lVeYTq06Z0WzzkfDbCefAgsk+TKM5AdwfDdMx
	5/fE4NElBY6oPs8KC9vi5HePldw3Wu/rdt3c6PW58Gm9dOmnxEIUuUhetIxS6gqyXEaqFOw54PIiI
	xmm5PXOT40xZawXb9tSC4tCgNhSy4fZbW6QzGb8qTXjYVFlGBTwMWf7bJe4/DYOrGZcRSSTSaLS41
	dXjUkH0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJdjJ-0000000Cv9k-3M2z;
	Wed, 21 Oct 2026 21:20:13 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJdjH-0000000Cv9H-2Ba0
	for kexec@lists.infradead.org;
	Wed, 21 Oct 2026 21:20:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id ADA43602D3;
	Wed, 21 Oct 2026 21:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2991F000C1;
	Wed, 21 Oct 2026 21:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792617610;
	bh=8SOYeN3mI9h0Q5+F0MQ98iCiGI8n0ATb68xRMfgn+1Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GbszFmmEXQz+GICcluEnq2IZMOk3ApLIptTiKA1AOcPy5Uj//hj/ZR/1M5+vVzB+R
	 tQUUo1tmA5yjeXxwhXQEFlywCUKE0Q0DuToB/ITP01C+TTGwr/fJ1iFrKpebpVHg2d
	 DBKtQRBqkiTNHFh5J1u9LIEkdDKvvdGi1Q0KN65i7MMxw8B6NWQRVABunyzP68GTYy
	 2jpsfnJGbbwavSvivEQRxy9KwzZFvf8HI78IHStUZpNkNxvYNO4O3I6lgGOMeT4UCk
	 8YovFzHbnVSlW/kuEsehR0DZfdpMCKtle+TPrGr3mXNedCfvWioNmHmK3DANAix6ox
	 KfnIpbPpSVtmA==
Message-ID: <sashiko-outbox-180694@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/2] memblock: don't allocate reserve_mem regions
 from KHO bootmem
To: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, "Mike Rapoport" <rppt@kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Kees Cook" <kees@kernel.org>, "Alexander
 Graf" <graf@amazon.com>, "Changyuan Lyu" <changyuanl@google.com>
In-Reply-To: <20261021211058.83483-3-azpijr@gmail.com>
References: <20261021211058.83483-1-azpijr@gmail.com>
 <20261021211058.83483-3-azpijr@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 21:20:09 +0000
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
Cc: Tony Luck <tony.luck@intel.com>, kexec@lists.infradead.org, Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush
 Yadav <pratyush@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> On a KHO boot, a reserve_mem region that can't be revived is allocated
> from KHO_NOPRSRV memory, which includes the bootmem the next kernel
> boots out of. With CONFIG_KEXEC_HANDOVER_DEBUG, preserving the region
> then fails:
>=20
>   WARNING: kernel/liveupdate/kexec_handover.c:1245 at kho_preserve_pages+=
0x168/0x180
>   failed to prepare memblock FDT for KHO: -22
>=20
> Without it, the next kernel puts its memmap on top of the region and
> the ramoops records in it are lost.
>=20
> Use the search that keeps HugeTLB pages out of bootmem, and keep the
> mirrored memory fallback of memblock_phys_alloc().
>=20
> Fixes: f99230780211 ("memblock: add KHO support for reserve_mem")
> Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021211058.8348=
3-1-azpijr@gmail.com?part=3D2


