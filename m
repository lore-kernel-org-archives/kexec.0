Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556DB606A320
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 21:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hKwzbLZp;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DXYkW3uI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=a9AiG3dreU4w0101UrqLnjG114y8MhZ6/kZYxcv89dg=; b=hKwzbLZpaidfkm5YrxK42Nw1kQ
	iJiWjh7OQpfZcPfrhmwSIM0Iw3v0OhBblDFiDMCbOvISNiMxGNZIovkNsKZCgWHDQEnWsbV2uxEJg
	sr6uazxN4rLLpd7uHdYNkonrimMXE13Oavv3T8LDAjgo06hAT9XFC8IZnok+h2itauvcPcghT9wEA
	bvEVoDH19k+7+Tc9C1aBFHuX1A2EtT2yCxG2fGbVILRMGt3u+WYGSq5nveCvmAmJRI8schT6jxbyB
	jzTXmcwoo+9d0U2ymoslMtvNs++WbZFCqkHoPsl0Q0gfydevXM5keK8o9pppXkeLeX4JRlFNasr6P
	oPghZDhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTnHQ-0000000AKVD-0HCb;
	Wed, 18 Nov 2026 21:33:24 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTnHP-0000000AKV3-1CjD
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 21:33:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1197F462A4;
	Wed, 18 Nov 2026 21:33:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B04F1F000C5;
	Wed, 18 Nov 2026 21:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795037603;
	bh=a9AiG3dreU4w0101UrqLnjG114y8MhZ6/kZYxcv89dg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=DXYkW3uInRAwJ1ojMozFJIFiX2l5f0srDcgguvkFIi837tMHNVXi0YTz6GonGm8Bt
	 gb00gxFfb2kdGOV7HO0f5aFHblEaUpt0BfoIXyQIVEtdKH0ygN+bsmHmOwQzhRCDXv
	 PN4BrCmrBSPATZQ15Ia1o7USk9Va8Kbd9em/zu+zpeXXf6bTaIUodwce0YC2HOAf01
	 qWTVZX3hDB9O84G+aSqupeFrako6G4IR2Ya8B15bLweSsvDt+w6bbKJzpx2tAgfdyL
	 Y4YPTyluBjWYBVnuXLi4EzibdGzcYKhuepqCPDh6Ga1hsdllNk0C8NFTkhrtXw7x4i
	 Y9nxA2sU5HcVA==
Message-ID: <sashiko-outbox-222004@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/7] liveupdate: luo_session: support incremental
 session serialization
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, rppt@kernel.org, shuah@kernel.org, skhan@linuxfoundation.org, vipinsh@google.com, corbet@lwn.net, dmatlack@google.com, kexec@lists.infradead.org, pratyush@kernel.org, rdunlap@infradead.org, graf@amazon.com
In-Reply-To: <20261118212845.2855249-4-pasha.tatashin@soleen.com>
References: <20261118212845.2855249-1-pasha.tatashin@soleen.com>
 <20261118212845.2855249-4-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 21:33:22 +0000
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

> In preparation for committing frozen sessions ahead of reboot, allow
> sessions to be serialized into sh->block_set individually. Introduce
> luo_session_serialize_one() to append a single session to sh->block_set
> and mark it serialized. Update luo_session_serialize() to freeze all
> remaining unserialized sessions first, rolling back on failure, and
> then serialize each one via luo_session_serialize_one().
>=20
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118212845.2855=
249-1-pasha.tatashin@soleen.com?part=3D3


