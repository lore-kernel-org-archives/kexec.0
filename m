Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87768606A326
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 23:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GJBaVrMG;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j3W2x16o
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=T9zc5UMk3mCiANRWKI4odT4nNxiEiREHUA2uJ27fhqo=; b=GJBaVrMGxqVS4925QY7zsWo+QM
	Sbaqjiacgpj26tFgb+1TJlM3uxBoUqtinQOknxGoN6zLymldN4Kl8hLf7NghdhHDMs9g+mwEm/USQ
	Dnlxsnpu1SZVNISEVheXcMvq175AZ08MjXTNgifJFK9RoEr9nzx2jULg/vza/+hJWBrQb5bBqNcH5
	0P/C2nGPZTeNGEQPOn4NrgmO8MyiVD7dj+NhTtXHB2zW8Z2sSscuzm7iV7mGha+SiMVJK4fFDlVMC
	TtwwdyDCIdKsWUOaLsQB+tMuhr37p8+RVYod2NB+oSX2p34JnvnxyogvwDzp/xoGliErNfSAtVzlI
	HSkOIQ2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRHy2-00000008A69-2DsF;
	Wed, 11 Nov 2026 23:43:02 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRHy1-00000008A5x-0nYa
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 23:43:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3FD66605D4;
	Wed, 11 Nov 2026 23:43:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FBE71F00A05;
	Wed, 11 Nov 2026 23:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794440580;
	bh=T9zc5UMk3mCiANRWKI4odT4nNxiEiREHUA2uJ27fhqo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j3W2x16o4OjoMPm7QoY2Xi6mrho9ddXVAv1ZbhNQ/i1SZ0gt/uoXH8G++MfhE2Bxg
	 O1VXoJf7YE5kWx+JJk9++fMMQXZWW9usp00dRTgjVZ1qm5BNahbPpzgb5ieUgHdJEn
	 XWqCHwnE/dGJCKqAZcgP0QLGOO9hN8D0bQ9pcczogOnt0wc0VLMEWgaqDq97noQWjb
	 V3DSbHSDq0OiZQLouPaUMk7G4W+pNWyqq93goaZcAB7CH33lz0LO0fVV60rGsoOBRL
	 k1g+EQ8+buxCsOQ8xADis18TFyMu2jNhPIIRw8XWAb5+XLY8G1Oo4AnCqC6ivESuEh
	 pYg8Mg8KkBneg==
Message-ID: <sashiko-outbox-209862@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] arm64: kexec: use a typed entry to fix kCFI oops
To: "Ben Cressey" <ben@cressey.dev>, "Catalin Marinas" <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Pavel
 Machek" <pavel@kernel.org>
Cc: "Kees Cook" <kees@kernel.org>, "Sami Tolvanen" <samitolvanen@google.com>, kexec@lists.infradead.org, "Nathan
 Chancellor" <nathan@kernel.org>, "Zhaoyang Huang" <zhaoyang.huang@unisoc.com>, "Jeson
 Gao" <jeson.gao@unisoc.com>
In-Reply-To: <20261111-arm64-kexec-nocfi-v2-1-ddf0c4aa326f@cressey.dev>
References: <20261111-arm64-kexec-nocfi-v2-0-ddf0c4aa326f@cressey.dev>
 <20261111-arm64-kexec-nocfi-v2-1-ddf0c4aa326f@cressey.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 23:42:58 +0000
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

> An arm64 Linux kernel built with CONFIG_CFI=3Dy oopses after "Bye!" on
> every kexec that relocates the image. Crash images load in place and are
> not affected. The oops reproduces under QEMU:
>=20
>  Unable to handle kernel paging request at virtual address 00000000544bff=
fc
>  pc : machine_kexec+0x104/0x274
>  Code: d5182008 d5033fdf aa1303e0 f9418a68 (b85fc110)
>=20
> b85fc110 is "ldur w16, [x8, #-4]", the kCFI check's load of the type
> hash in front of the callee. Commit efc2d0f20a9d ("arm64: kexec: keep
> MMU enabled during kexec relocation") made machine_kexec() call the
> control page's copy of arm64_relocate_new_kernel() indirectly, while
> TTBR0 maps only that page. The copy starts at the page's first byte, so
> the load faults. SYM_CODE_START() also gives the routine no hash.
>=20
> [ ... ]
> Fixes: efc2d0f20a9d ("arm64: kexec: keep MMU enabled during kexec relocat=
ion")
> Cc: stable@vger.kernel.org
> Suggested-by: Kees Cook <kees@kernel.org>
> Link: https://lore.kernel.org/linux-arm-kernel/202609241804.BB23BF10@kees=
cook/
> Signed-off-by: Ben Cressey <ben@cressey.dev>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-arm64-kexe=
c-nocfi-v2-0-ddf0c4aa326f@cressey.dev?part=3D1


