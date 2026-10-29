Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A28606A31A
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 17:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BCa2bmdy;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ei/+rxhm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=n2C9Awijc1K0wA/qMXpcJQBuyDQWDfVkocmmGpRkinQ=; b=BCa2bmdywns3UPnCfZLpB+kCp9
	xeTIwImDW3ijnigjeqd33w2qA31vjuKutmCtQYS6C0eTJVkZmaSCBX6Ksk8AFs/lHuhhI+G/2l597
	C1wX8gWIvEPDaK3nm854fgfOCNxqfJUmPm06GiJkZmXjYL0O/sOVlRiPCxJFNcqx2vb4rdJjykqfA
	vjMKz3+p4dCdxVP8YoucmZlnk2byhwtvN0QYLfnOMnr591WwFWDHs/byzjOJVbLkp2stb14ZLmFGZ
	W2FSMiLdXg9SupQC4SftvD29nUUsNWXOU2Vlj6xmNlKZ2G+tDSiUyxmxJW+6oPI4d19BzcBV44UcA
	ScOBQEYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMUDi-0000000A0N2-2q6y;
	Thu, 29 Oct 2026 17:47:22 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMUDg-0000000A0KK-3c3j
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 17:47:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6E14240357;
	Thu, 29 Oct 2026 17:47:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90DCC1F01816;
	Thu, 29 Oct 2026 17:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793296040;
	bh=n2C9Awijc1K0wA/qMXpcJQBuyDQWDfVkocmmGpRkinQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ei/+rxhm0etnZonEtmCqmAgTm6Tf6tRXYcH+DfEBPjyjfdzUdTEylBCNqMtVlqXZ2
	 SZuKaX9Zgb9y0PeA7U10d+95cEwCD1+On5z5vD8hfU/18uQHzsLCJW09ya8Lfxcrq5
	 8cbOvCGWxewYptdl0vrzOEHyy/Ps/bFoaLOWDde02139T5NxCSh+ucEvufGHamnqfg
	 a2wHE7pmmM+Jc+k7KdwK3sD/AGcaFOfzEhv2Iarh3uf0V88bclPHLiP2aVoaJo64wk
	 a4eIiozKycm0aJvnvTZ/YCavG6f2zkwEra1U+VZo+vEtZ72YBychC7HAFzWLgLpvhK
	 O0Knk2gS0AVuA==
Message-ID: <sashiko-outbox-189750@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 7/8] selftests/kho: Add LoongArch vmtest support
To: "George Guo" <dongtai.guo@linux.dev>, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, chenhuacai@kernel.org, ardb@kernel.org, shuah@kernel.org
Cc: ilias.apalodimas@linaro.org, akpm@linux-foundation.org, baoquan.he@linux.dev, ruirui.yang@linux.dev, guodongtai@kylinos.cn, kernel@xen0n.name, graf@amazon.com, liukexin@kylinos.cn, kexec@lists.infradead.org
In-Reply-To: <20261029172956.20791-8-dongtai.guo@linux.dev>
References: <20261029172956.20791-1-dongtai.guo@linux.dev>
 <20261029172956.20791-8-dongtai.guo@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 17:47:19 +0000
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

> From: George Guo <guodongtai@kylinos.cn>
>=20
> Add loongarch.conf to run the test on QEMU's LoongArch virtual machine
> with a la464 CPU and an 8250 serial console, and let vmtest.sh accept
> the loongarch64 target.
>=20
> Boot vmlinux.efi through EFI firmware. The EFI stub installs the KHO EFI
> table, and QEMU's direct kernel boot would skip the stub. QEMU_EFI
> defaults to /usr/share/edk2/loongarch64/QEMU_EFI.fd and can be set for
> distributions that install the firmware elsewhere, such as Debian's
> qemu-efi-loongarch64 package.
>=20
> QEMU's LoongArch virtual machine has no i8042 controller. Enable the
> generic PCI host so its I/O space is mapped before the i8042 fallback
> probe touches the legacy ports. This keeps i8042 enabled, so the same
> kernel configuration still works on real hardware.
>=20
> Enable ACPI_SPCR_TABLE so the bare earlycon parameter gets the UART from
> the SPCR table installed by EDK2. Unlike x86, LoongArch does not enable
> it by default, and without it there is no early console and vmtest sees
> no early boot output.
>=20
> The KHO vmtest needs CONFIG_DEFERRED_STRUCT_PAGE_INIT=3Dy, which depends
> on SPARSEMEM, so select CONFIG_SPARSEMEM_MANUAL=3Dy.
>=20
> Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
> Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029172956.2079=
1-1-dongtai.guo@linux.dev?part=3D7


