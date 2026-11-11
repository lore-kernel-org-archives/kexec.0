Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83DE606A31C
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 23:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=AGemxVaz;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kzqpPxlf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=BDXI5t6HYFkwBkTs5giGrH4imh+3Bz2X2SUCTz6+bNM=; b=AGemxVazqWs64PIjzJ+WMzs0ru
	KyUIKQ4CML1HEUPcfHLkHB2mYbuK1/egNQzV7X/I1Gk/Mk8A35U/W6wJTb0ZASrADyYRW51dGBfn2
	egN83UOLVCF+XItgqyLXv+r/rGPfYgAyt+65BWMGvsDKYYJlqu2oQSp0UpduHtkgq0MfGkB7Uzr4x
	BHY/nZeJFUxAZTCq9riWuE9TwlDIwkC/zmC60EOxcydHqPDsKr6Bk+GYtN7fFrE1v5BeG8Awi6vpN
	2N4c/QpVTnuuCLhl4sfLkgJhBwvMDOAPQtR0TOIIk3rReylk/zUTvkkgTxM9alYNoZB670VeReEC0
	8F81TDBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRHyC-00000008A8k-2XQ5;
	Wed, 11 Nov 2026 23:43:12 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRHyB-00000008A8c-3KJw
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 23:43:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2D61540E83;
	Wed, 11 Nov 2026 23:43:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E921F00A05;
	Wed, 11 Nov 2026 23:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794440591;
	bh=BDXI5t6HYFkwBkTs5giGrH4imh+3Bz2X2SUCTz6+bNM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kzqpPxlfc1R1Tp8Fxl543PtXrV22+J6O6JcG14poCNnjWlBl7uctEIsGiV8eFFO/k
	 R51Pi+t8YPCfIbhGw/UTu4RYX0COAlZxdC8d1nROneRj2m/7LrapJtiYQzx+wYyJcE
	 99cRkw6GO4EyQmBXxh17NwcTyf0VzkoU1MEXzQxci6HUJ4eMs46WDiOzS3I8EXeMvT
	 WoXhVZqJ4Z8WP1KYaXTmvU3qtt/yVT6SEeDEMe+3uS28ZLQT91g3BksYtgEYzVwdE8
	 5WmE63uyrztKOzIwTDAXoDvVMFmBFLKiQM0y79OB0FrckAfwEJHuM6oPVRZqRQYbkU
	 Cca7elTtYdkAQ==
Message-ID: <sashiko-outbox-209863@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] arm64: hibernate: use a typed entry to drop
 __nocfi
To: "Ben Cressey" <ben@cressey.dev>, "Catalin Marinas" <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Pavel
 Machek" <pavel@kernel.org>
Cc: "Kees Cook" <kees@kernel.org>, "Sami Tolvanen" <samitolvanen@google.com>, kexec@lists.infradead.org, "Nathan
 Chancellor" <nathan@kernel.org>, "Zhaoyang Huang" <zhaoyang.huang@unisoc.com>, "Jeson
 Gao" <jeson.gao@unisoc.com>
In-Reply-To: <20261111-arm64-kexec-nocfi-v2-2-ddf0c4aa326f@cressey.dev>
References: <20261111-arm64-kexec-nocfi-v2-0-ddf0c4aa326f@cressey.dev>
 <20261111-arm64-kexec-nocfi-v2-2-ddf0c4aa326f@cressey.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 23:43:10 +0000
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

> swsusp_arch_resume() calls the safe page's copy of
> swsusp_arch_suspend_exit() indirectly, without a kCFI check. The MMU is
> on at the call and TTBR0 maps only that page. The copy starts at the
> page's first byte, so the check's load of the type hash in front of it
> would fault. SYM_CODE_START() also gives the routine no hash.
> Commit e2f8216ca2d8 ("arm64: Set __nocfi on swsusp_arch_resume()")
> disabled the check "for now", since the entry had to be first
> in .hibernate_exit.text.
>=20
> SYM_TYPED_FUNC_START() emits the hash inside that section, and
> create_safe_exec_page() already copies the whole section, at most 4 KiB,
> to the page's start, so the page holds both hash and entry. Relax the
> linker script's ASSERT, so the entry need only be in the section.
>=20
> Fix by typing the routine, with a C prototype, entering the copy at the
> symbol's offset in the section, and dropping __nocfi.
>=20
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Link: https://lore.kernel.org/linux-arm-kernel/arZSe8hNnRPM5FqY@J2N7QTR9R=
3.cambridge.arm.com/
> Signed-off-by: Ben Cressey <ben@cressey.dev>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-arm64-kexe=
c-nocfi-v2-0-ddf0c4aa326f@cressey.dev?part=3D2


