Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AE4606A326
	for <kexec@archiver.kernel.org>; Sat,  7 Nov 2026 07:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jwkmWE0D;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uu3lF2Tf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=dBNTKP0FKH1YNDcDw8U/oGhzBE3eDgwIdFOREkcft5s=; b=jwkmWE0Df2QvF1Lp1eEdiaEZPr
	ei0XkF2y7hp6cJoDg6VLWhDWOT6olXDYIK3gFSD6MBDv847CmlJafw3IRz6UrwF4EbvWW0ypKz7Hq
	iW62Ekp+352hRLphYe4Xx0R+8BWUz0BrGxAw/72yfCcvKEnraG1nAlu9MAuoiQXHONwCb/JF1iNMJ
	Q9qY2EbI5BU8B5aaXO3eycgNsiSXCDRMgHmVblVzkvro+nlQPPFuJlnCizetiegl2AEH/NPL+pl6d
	58tWnU5oSJ+/p58xBh02gomONqDcJuaa2zgHnzZJhIWXxgiAmDreJZ3gDjKkz7DnVM2WVkIDC1nBU
	1G5rtd9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPaeJ-0000000EIws-3JVn;
	Sat, 07 Nov 2026 07:15:39 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPaeE-0000000EIwW-3AtO
	for kexec@lists.infradead.org;
	Sat, 07 Nov 2026 07:15:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C3DA741278;
	Sat,  7 Nov 2026 07:15:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D131F0089F;
	Sat,  7 Nov 2026 07:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794035733;
	bh=dBNTKP0FKH1YNDcDw8U/oGhzBE3eDgwIdFOREkcft5s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Uu3lF2TfVgnFYS4CNmATFOb4gcNcZEHY7dvlHmxUiLhVeOlJo1a0FVW2woKP9VQx1
	 Gyq7Uq5bwNCElD0KJHlpL5DxswsoatMOevmYI7cAE5vIwOZEgZJGceiUDkH2RM/eX5
	 he7Ufs4hzZT8TXPtZ7jNflQtw51mIQdLWa60pYik5HXHbxyp3OqszJ+NL/qt0fWAYd
	 lf2hWcufVegw3EipE79/LS6MJyWyyp/DL6sL1nZMC59veXxEBhhpy95w9TekwH1gs8
	 wHLHLRSIcTtfaxxx3SgZEdSuQBf+toCfsoOLflSzjkLWsoL7MLVvwL0b2djSD3OWnH
	 37853yxT/DsMg==
Message-ID: <sashiko-outbox-202682@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] riscv: Call early_ioremap_setup() before parsing
 the DTB
To: "Chen Pei" <cp0613@linux.alibaba.com>, pjw@kernel.org, palmer@dabbelt.com, alex@ghiti.fr, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, graf@amazon.com, shuah@kernel.org
Cc: guoren@kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261106071459.2003-2-cp0613@linux.alibaba.com>
References: <20261106071459.2003-1-cp0613@linux.alibaba.com>
 <20261106071459.2003-2-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 07:15:32 +0000
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

> parse_dtb() can reach early_memremap(), whose return value is composed
> from the slot table that early_ioremap_setup() fills in - and on RISC-V
> that setup ran after the scan, so the mapping came back NULL. The DT
> based kexec handover parsing is the first caller to hit this:
> kho_populate() cannot map the handover FDT and the handover is dropped.
>=20
> Run early_ioremap_setup() before parse_dtb(), as arm64 and x86 already
> do.
>=20
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106071459.2003=
-1-cp0613@linux.alibaba.com?part=3D1


