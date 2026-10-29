Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D34606A31C
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 17:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KOcnKhpp;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L40Suo6V
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=TH9xFf93zUtKrVPunMc0iVZSPFnBxCWc60oiqEFUILU=; b=KOcnKhpputudLoquSIcdH3h3WF
	JxGxB4diupH1oCjDOzzB8S3vKLWCLqa6yJwU712x6aIO8rSgedtBjsLqZDsckG1mrx0yLrSWHcC/+
	BA7rfMBme7oZxEhkbqLtLVpSSFIkIdAoBFyZdjQjwsSIBAznqtJ8r7uhX4zhtTx4iFWqdFEXhKbhA
	sx7b9OVZBW/aoVo1yrhkbRbFZ22cc3C0SmC8ouzpDGzjQLA02aklrUmOvfsslyjWrfwGn0NfcDG3C
	I3OmAklCg1kRaXXXKHN1qzly7nzqp2N+GfveN09lWI8hds/aSGHUvygbiR9te74DKWgPnG5LmdZFb
	KJNLrvJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMUDf-0000000A0Iv-0ghn;
	Thu, 29 Oct 2026 17:47:19 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMUDc-0000000A0H2-483F
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 17:47:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BA0F643FF2;
	Thu, 29 Oct 2026 17:47:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3351F01816;
	Thu, 29 Oct 2026 17:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793296036;
	bh=TH9xFf93zUtKrVPunMc0iVZSPFnBxCWc60oiqEFUILU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L40Suo6VK9JjgcIDl/q8wvjBlPTB+Ag9L1JNmfRiqawmEq4bgrR1dWYkJGzlvmdvw
	 SfHLQGXm9HSFRHrHHKoBv9yP0lsLyApg+7ryvP8IrjNotd3RhT4aZS3LigNsnB/VJd
	 E5kRK3N1ghb4FQkpQSKv5lJIlchrz0U7dqHD9foDZwLMbqxtQjitv2eDvdIIWZUKH6
	 cpckGxVXXiRSk9EWlsJ7CbOZcdzrFEqcaaORzrom6JSVeuZ8K0FerNO5utJR3g7Ae8
	 ShwV6yFJwfdDTs0LeFB7gKI1oduy3OUGheeaIUvm1a4s6xX/1De7u7tck1v1z5qQuL
	 TKFsA6cu4s3iQ==
Message-ID: <sashiko-outbox-189747@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/8] kho: Add kho_disable()
To: "George Guo" <dongtai.guo@linux.dev>, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, chenhuacai@kernel.org, ardb@kernel.org, shuah@kernel.org
Cc: ilias.apalodimas@linaro.org, akpm@linux-foundation.org, baoquan.he@linux.dev, ruirui.yang@linux.dev, guodongtai@kylinos.cn, kernel@xen0n.name, graf@amazon.com, liukexin@kylinos.cn, kexec@lists.infradead.org
In-Reply-To: <20261029172956.20791-5-dongtai.guo@linux.dev>
References: <20261029172956.20791-1-dongtai.guo@linux.dev>
 <20261029172956.20791-5-dongtai.guo@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 17:47:15 +0000
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
> On LoongArch, KHO state is passed to the next kernel only through an EFI
> configuration table. Only the EFI stub installs this table, during a cold
> boot.
>=20
> A kernel entered through kexec does not run the EFI stub, so it cannot
> create the table if the previous kernel did not provide one. Without
> the table, it cannot pass KHO state to the next kernel on a subsequent
> kexec.
>=20
> Add kho_disable() so architecture code can turn KHO off when the EFI
> configuration table is missing.
>=20
> Signed-off-by: George Guo <guodongtai@kylinos.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029172956.2079=
1-1-dongtai.guo@linux.dev?part=3D4


