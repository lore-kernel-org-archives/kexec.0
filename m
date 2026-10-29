Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10715606A31D
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 17:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TbIYeQ+n;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kcRnpPJD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=J/TblnclnFoCka+GHUfBxKb2uy4EUXad9o50TA7nORg=; b=TbIYeQ+nn/l7ezFsnKBO+iD3xF
	KiP5YXwgMhFAa5nRNCcAbJ4ub+E4y10M8TL49F2LCKE8rjPyRR4bT0QC22Nrp9BfnXji5ocrJCIV3
	XpmsxATVHsFa4mcPkxsraHWbtjqOvhjPbw4r02pMRBPFkmGamxSRUgyuO9/2xCCqyJxe1p/B0KBfV
	ljlzPLSInqshZe1dO9qPn/8kHDIQAn3+H8COCgQ+CwoB8fQKBKEt8PBVkKbSMkfTBSDtMr8ktdPJX
	P+fcHw2Zcsfo+tWsQb1sOdBoa5sZCqnA2TIVUY08LxF/uTNgGo1kQFDOVFjfa8HteVVIS9Kns7Tai
	OLUky9dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMUDb-0000000A0GF-3jw0;
	Thu, 29 Oct 2026 17:47:15 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMUDZ-0000000A0Fq-3pp3
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 17:47:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 08DB043E5C;
	Thu, 29 Oct 2026 17:47:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38FBB1F01816;
	Thu, 29 Oct 2026 17:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793296032;
	bh=J/TblnclnFoCka+GHUfBxKb2uy4EUXad9o50TA7nORg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kcRnpPJDPNH/Ew7RxOhmUgl2lCv88KchSLZGjH9sV43pz50vCQ3uXwYrDpzWiBDus
	 jkc7Z1Vx/bs04C9iEXjYHuyfSo9wcZ4mILv0m4M2cB5/oTGEFXOdgY0YCmk5nvzMGM
	 gUEoVR5YPHfUAMrYVNdMoFsMzmoW4EsLpFvLfNxPf5fvQGTzGI5gn5vZIj3cz2+zC4
	 wC3+fhrrtjZ0x1kSvKX6vEjqW3QVi89zJ7/0tZilHbWdBB56bKeduLbV/V6iH1Kc/D
	 I799pSlNlBqS7f/7YpeObZ4Si/+YKHTWdt2ofNVNcXDL/qM+GiZEXmN8D35n4dBgay
	 5BWeitw5lRnHg==
Message-ID: <sashiko-outbox-189744@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/8] efi: Pass KHO state to the next kernel in a
 configuration table
To: "George Guo" <dongtai.guo@linux.dev>, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, chenhuacai@kernel.org, ardb@kernel.org, shuah@kernel.org
Cc: ilias.apalodimas@linaro.org, akpm@linux-foundation.org, baoquan.he@linux.dev, ruirui.yang@linux.dev, guodongtai@kylinos.cn, kernel@xen0n.name, graf@amazon.com, liukexin@kylinos.cn, kexec@lists.infradead.org
In-Reply-To: <20261029172956.20791-2-dongtai.guo@linux.dev>
References: <20261029172956.20791-1-dongtai.guo@linux.dev>
 <20261029172956.20791-2-dongtai.guo@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 17:47:11 +0000
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
> KHO has to give the next kernel two addresses: the KHO FDT and the
> bootmem area list. arm64 and riscv put them under /chosen in the boot
> FDT. LoongArch systems booting with EFI and ACPI do not require a boot
> FDT, so KHO needs another way to pass this information.
>=20
> Add a Linux EFI configuration table for them, under
> LINUX_EFI_KEXEC_HANDOVER_GUID. It points to a struct linux_efi_kho_data.
>=20
>   - On a cold boot, the LoongArch EFI stub installs the table, zeroed.
>     Each kexec'd kernel is given the same EFI system table, so it finds
>     the same table.
>=20
>   - In early boot, efi_config_parse_tables() reserves the table so
>     neither the page allocator nor kexec segments use it, and calls
>     kho_populate() if the table holds KHO state.
>=20
>   - Provide efi_kho_update() to update the table before kexec. Map the
>     table during boot so updates do not require allocation or mapping
>     at panic time.
>=20
>   - efi_kho_table_found() tells architecture code whether the table was
>     found at boot, so it can turn KHO off when the table is missing.
>=20
> Only the LoongArch stub installs the table, and only with
> CONFIG_KEXEC_HANDOVER. Elsewhere there is no table and this code does
> nothing.
>=20
> Signed-off-by: George Guo <guodongtai@kylinos.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029172956.2079=
1-1-dongtai.guo@linux.dev?part=3D1


