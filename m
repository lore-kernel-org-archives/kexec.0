Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1125D606A31E
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 17:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rUlsm25G;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dxIvpWB4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=SAYu61RYDwvXBzNIWA+ow0GrHahUTXC8n0IfKR7EdNQ=; b=rUlsm25GgODPs0K4Y/qVVHistt
	xJ0lqBhv59RB6I8gsQvH6i8d+J0Id/1lqR4L7MIobCCmUu6EagbGOJWMtZ28qu7FgkzIrGNYTwIwY
	R0gvPOcN45tmDbCmC0k8iZNVFZfxcVldTdqPdhJiDfXlCqemNu6sX7XjSlLTTpuH1q7VCNvOBNN/m
	kYVoHFtj7GTg/tpT4Nuy5x6ncOUupjCzdERp3EFM1g48YxbyysyehURDdZzC6d4wztg4ULFQ1UEPm
	eAmFPySMHY/sRPMPfHU2jgonzjXTZyMqBiJc/yjWBkDQ537B+l1BTUG5dRsjDAyTkjscmwRvVUnKt
	WoiC6cmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMUDb-0000000A0GL-407X;
	Thu, 29 Oct 2026 17:47:15 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMUDa-0000000A0G7-24U8
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 17:47:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 43E1941405;
	Thu, 29 Oct 2026 17:47:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A5C1F01816;
	Thu, 29 Oct 2026 17:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793296034;
	bh=SAYu61RYDwvXBzNIWA+ow0GrHahUTXC8n0IfKR7EdNQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dxIvpWB4q1L+y8ahT2+VDbJLphK7gbfdWPqtH5KKNSpJ+D7dYqgHZGqLO3RN33PTn
	 rvZgRodxCrmbbPpnT/0+vSEN8TgY93VWECTyUNtdH8TjFJLKBofg+dIRDvVb2jYgKS
	 IPpLiFI+MZVhqW2VI5jrSYsjp5mj0lqXuoz00cuaJLkMUz1g+BZnVp30n6O1WtL+ne
	 cfZNFBM1YpYOKG8LM9TsqyRxA1Pnrhd83yF1epgGq1wzrwFCUCiafI5wqCGTYpk9PE
	 g5Om//9cauMjVNiVZltoF9PrR7jD0HMkEhyX0jLRjiXR/dCb8XN4WtUP2Gs6pxoySV
	 co0WjMad5+a4g==
Message-ID: <sashiko-outbox-189745@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/8] kho: Write KHO state to the EFI table at kexec
 time
To: "George Guo" <dongtai.guo@linux.dev>, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, chenhuacai@kernel.org, ardb@kernel.org, shuah@kernel.org
Cc: ilias.apalodimas@linaro.org, akpm@linux-foundation.org, baoquan.he@linux.dev, ruirui.yang@linux.dev, guodongtai@kylinos.cn, kernel@xen0n.name, graf@amazon.com, liukexin@kylinos.cn, kexec@lists.infradead.org
In-Reply-To: <20261029172956.20791-3-dongtai.guo@linux.dev>
References: <20261029172956.20791-1-dongtai.guo@linux.dev>
 <20261029172956.20791-3-dongtai.guo@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 17:47:13 +0000
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
> On arm64 and riscv, KHO addresses and sizes are passed through /chosen
> properties in the boot FDT prepared for each kexec image. On x86, they
> are passed through a SETUP_KEXEC_KHO record linked from the image's boot
> parameters. These records are per-image, unlike the shared EFI table.
>=20
> The EFI table is shared. A KHO-enabled normal image and a crash image
> can both be loaded, but need different contents: the normal image needs
> the KHO addresses, while the crash image needs an empty table. Updating
> the table at load time cannot satisfy both.
>=20
> Write the table in kernel_kexec() and __crash_kexec(), once the image
> that will run is known. kho_update_efi_table() fills the table from that
> image, or zeroes it if the image has no KHO state, including images
> loaded with kexec_load().
>=20
> Clear the table even with CONFIG_KEXEC_HANDOVER disabled, since the
> kernel may have inherited a populated table. This prevents a later
> kernel from trying to revive obsolete KHO state.
>=20
> The table stores the size of the bootmem area list (bufsz), not of its
> page-aligned segment, as the FDT and x86 code do. If updating or clearing
> the table fails, kernel_kexec() returns before liveupdate_reboot(), so
> LUO does not save state that the next kernel would not find.
> __crash_kexec() ignores the error so the crash boot can still proceed.
>=20
> Signed-off-by: George Guo <guodongtai@kylinos.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029172956.2079=
1-1-dongtai.guo@linux.dev?part=3D2


