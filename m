Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC313CCF2D4
	for <kexec@archiver.kernel.org>; Mon, 19 Oct 2026 02:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ki6hFPctTQSYddc3Xj8mdkgkYRyfub8s0VS32xp1qxE=; b=I+tv3NkaM/oyg0fiWitjof2t+N
	sOJRUQInl6QsLD+CMqtXkGBuzhlcVW7JRWGMqvoRPY6vta80eBmxaZtezZ1VwpedJpq4f4/6z5aFf
	iYQni30GL/WiIIS314ywpg6iMll5vZ5x7qpCW4gmGqDdpg1EifjwCg/kDzWmprbYzlRIqkTJzVRtF
	VkdVgK1gjQXsRTdh2PWFcpXr9avuHXC2K2cxnlKlrUQ6EQF9zHzT4zDt4/H+MTjaPiS125Xw+EugX
	gX7cGzkrI3pxuZWI/WY/zmjeWijrELlyoQr0zngygtfsOTONMcy7Ewh5qDre1VyzRh5uY8i2VHRpL
	uPlyZGyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIcxq-00000006SRP-3kdL;
	Mon, 19 Oct 2026 02:19:02 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIcxm-00000006SOz-4844
	for kexec@lists.infradead.org;
	Mon, 19 Oct 2026 02:18:59 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B90AB41164;
	Mon, 19 Oct 2026 02:18:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48CD1F000C4;
	Mon, 19 Oct 2026 02:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792376338;
	bh=Ki6hFPctTQSYddc3Xj8mdkgkYRyfub8s0VS32xp1qxE=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=N1Fo2UX3nSktSOereIiZXsr7B6YMswquOKoMg/FDvOBN0zew1oJ/kyRA9U39qIWSu
	 TieFRdkE5DfOjSGxFtGEMtAy6HK+U20Vg85o0409e65/1UpRMcpbF5V9gBoo7SCNOH
	 AqsrFVEGAuf+pPKZhyM5nWglcVlW4+XKqXYBTcq35aj+7Y85CBLwlYK07f5XvXfG05
	 joGkjzrpibEIyvW4PrIO/kJfUG+73c2y8UjPvjaxxgJ5ygq9xbdPj6oxCAgx/CejXr
	 KKx06cNLMjcL/pucXwrIiLVCPeabDlLT2b3jNA6ZhJYGQl/KZlyE9995bPr0YvzieU
	 i3Z6zppU3uvoA==
Message-ID: <sashiko-outbox-176522@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 5/8] kho: add read-only Kexec Handover mode
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, rppt@kernel.org, kuba@kernel.org, enelsonmoore@gmail.com, bp@alien8.de, shuah@kernel.org, david@kernel.org, akpm@linux-foundation.org, ljs@kernel.org, mhocko@suse.com, skhan@linuxfoundation.org, vbabka@kernel.org, dapeng1.mi@linux.intel.com, corbet@lwn.net, surenb@google.com, kexec@lists.infradead.org, pratyush@kernel.org, rdunlap@infradead.org, elver@google.com, graf@amazon.com, lirongqing@baidu.com, liam@infradead.org, jlayton@kernel.org
In-Reply-To: <20261019021111.990394-6-pasha.tatashin@soleen.com>
References: <20261019021111.990394-1-pasha.tatashin@soleen.com>
 <20261019021111.990394-6-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 02:18:56 +0000
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

> Add CONFIG_KEXEC_HANDOVER_READONLY and the 'kho_ro=3D<pa>' kernel
> command-line parameter to support traversing a preserved KHO tree in
> read-only mode without taking ownership of or modifying KHO metadata or
> reclaiming preserved pages into the page allocator.
>=20
> When booted with 'kho_ro=3D<pa>', preserved KHO metadata (FDT, radix-tree
> nodes, and vmalloc chunks) lies outside the kernel's direct map and is
> mapped read-only (PAGE_KERNEL_RO), with the FDT and radix-tree nodes
> mapped lazily on first visit and kept cached. This allows
> kho_retrieve_subtree(), kho_restore_vmalloc(), and
> kho_ro_lookup_folio_order() to inspect the preserved KHO state while
> leaving it intact.
>=20
> Also export kho_ro_map_folio() and kho_ro_unmap() so callers (such as
> kho_block, LUO, and file handlers) can map preserved folios verified
> against the KHO radix tree with the desired page protections.
>=20
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019021111.9903=
94-1-pasha.tatashin@soleen.com?part=3D5


