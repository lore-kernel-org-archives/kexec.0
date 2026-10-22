Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746ED606A319
	for <kexec@archiver.kernel.org>; Thu, 22 Oct 2026 08:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=s2EZR9mh;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ChS7ahX/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=TBQ8RquO7S05BjbJj/npcSCQemkNCogW2NxZMt7nkFc=; b=s2EZR9mhoZpxzL/9V1nfC1exb6
	B3ScVr85p7ujPTe4bVqHzr2y6Af12ZHOJ5hAz0d4lZnY3EfEPrAYGTZS2FImWiFdOWkTEVBowvJEK
	wRAeZnG54cAHNJB74/8yZkiTKS97x/hTCJ7JTVAa4GtaPeOxSsvI0MO6B+xfD4fcdJj93SVF3YbNP
	ZmOFwOvrS4PvEy8YWsCxDFqH+S5bGVHE7DehpvXFtQj66Xg2g1pc7+j339M3onymvrDpIA+AIAgBI
	kmKB5hKNUn/zAvh0uR6l6w1CRQw1JnxnGitkKbIyNCedEg7Ab6PV9lHKMww2bvLAt4kA9y+MRVM7p
	Oqju7tQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJoEd-0000000Dfum-0jnk;
	Thu, 22 Oct 2026 08:33:15 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJoEa-0000000DftM-1uKv
	for kexec@lists.infradead.org;
	Thu, 22 Oct 2026 08:33:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3510F42DA4;
	Thu, 22 Oct 2026 08:33:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A371F000C1;
	Thu, 22 Oct 2026 08:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792657992;
	bh=TBQ8RquO7S05BjbJj/npcSCQemkNCogW2NxZMt7nkFc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ChS7ahX/8Mpqd9d5+AaDDkSnnmRNPz5WYBXKX6tHuCF05e8DDbcX1E20f4X7ZVLDd
	 zlXbEOBopAkUTUQemhq2Hr+hHzMn9QKX9C5iJBDuuNz4pb37eVQg2lxlw1cPWqwcNy
	 089Lu4aVdD5tb2a3G0YmWzAYDl1UmeISYph2u10D1EJC1ZFc0e5rdPUI89WFhokIGQ
	 McunZ3w82BmpUA2eG1iXCf9OBJcPd9yDXrkrHDMAV/ui/Man2a/H9GA2oLFlcimCmC
	 bAS8y5fmbQ3K0lsTXqemxGEmPIH2zOpmrXhaduG2PQGLVp863xRK9Tk1pA3EUVGeCB
	 YZcQIz192G9xA==
Message-ID: <sashiko-outbox-181180@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 4/8] crash_core: replace for_each_mem_range() with
 for_each_mem_region()
To: "Wandun Chen" <chenwandun1@gmail.com>, robh@kernel.org, baoquan.he@linux.dev, rppt@kernel.org, m.szyprowski@samsung.com
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, saravanak@kernel.org, akpm@linux-foundation.org, pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev, robin.murphy@arm.com, kexec@lists.infradead.org
In-Reply-To: <20261021083011.2170525-5-chenwandun1@gmail.com>
References: <20261021083011.2170525-1-chenwandun1@gmail.com>
 <20261021083011.2170525-5-chenwandun1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 08:33:10 +0000
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

> From: Wandun Chen <chenwandun@lixiang.com>
>=20
> for_each_mem_range() skips MEMBLOCK_NOMAP regions implicitly. Switch the
> weak defaults to for_each_mem_region(), which exposes struct
> memblock_region and per-region flags, and filter NOMAP regions explicitly
> via the new crash_should_skip_region() helper. This prepares for a
> subsequent patch to extend the skip filter.
>=20
> No functional change.
>=20
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021083011.2170=
525-1-chenwandun1@gmail.com?part=3D4


