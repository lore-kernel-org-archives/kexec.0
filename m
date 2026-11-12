Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C224C606A331
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 10:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BUhaBH7w;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LDdLZCF9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8w0gKzFTe55eUAn7Zuejuv/Ru0HVhu/LD9nYp3PWpMc=; b=BUhaBH7wIZ8egIlbTo/W0S79Gr
	0XQCKHwxxeOvucH+KmqdhSsO85oAOY7QOByHmTTfYIWdHuOGg16A1qjE/TX5AdhafgX7DyjR5MixL
	8xfC+Bfscvu0QDB3rU8ptXExLKEC/U+K3J9V97KdkefCJDFcYm8hvhPMOMLCLz8mmH2hBW50ff0lj
	ONa59UPoaCK/EG/Jhvlvy1XoJCbUdjm6NmHbKUjnQVwSnQwOylRW53zKIEjirM9Hv/Mu0Ag2ie1lZ
	GXmN4IoOAcgDecb06Mzm9+3yg1sPGBxX/JGg5B5vRb0WyQlaD/d9lQgUx5Jf8JcRQ2T6SAu/6FNLp
	J2ooskfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRSLb-00000009aPY-1uyw;
	Thu, 12 Nov 2026 10:48:03 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRSLT-00000009aLK-2Olx
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 10:47:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 37F78479E6;
	Thu, 12 Nov 2026 10:47:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7984E1F00A06;
	Thu, 12 Nov 2026 10:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794480475;
	bh=8w0gKzFTe55eUAn7Zuejuv/Ru0HVhu/LD9nYp3PWpMc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LDdLZCF9TS48ZF5jpytvzbU+YAkooFc33hiNfKf5PX+lF8bWmCG04N3ZaDRxIfTWd
	 UyJ80HXEKd++f9Xl1VOmB/h9qbaXKQikkhNVXv3qszQfxfehdicDCf0JwsQRGkqCZQ
	 qHHXSdnaVizFECJXg4QkfAOUPBAmS98e3RV0eVJ2FpgmKJN9ltJMhSK2plx6/ppiDl
	 Bu/EbDPA9ApYCprDc+uOYneOTlQ5EskeYoumhYSCd+i1anNXEXa5jzgR/mqozwCqXJ
	 fpI7H3cfcnmDDz6FV9vPo5krtht5dEvL/+ycQwu3F4xhhZdiDzM7/N/WwVouFbSp1Y
	 hFPUF1K/6IzYA==
Message-ID: <sashiko-outbox-210973@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/5] kho: docs: update description of bootmem regions
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>, "Jonathan
 Corbet" <corbet@lwn.net>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pratyush
 Yadav" <pratyush@kernel.org>
Cc: "Alexander Graf" <graf@amazon.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Chen
 Pei" <cp0613@linux.alibaba.com>, "George Guo" <guodongtai@kylinos.cn>, "Kexin
 Liu" <liukexin@kylinos.cn>, "Randy Dunlap" <rdunlap@infradead.org>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Sourabh Jain" <sourabhjain@linux.ibm.com>, kexec@lists.infradead.org
In-Reply-To: <20261112-kho-bootmem-sizing-v3-5-f0c8d00295d5@kernel.org>
References: <20261112-kho-bootmem-sizing-v3-0-f0c8d00295d5@kernel.org>
 <20261112-kho-bootmem-sizing-v3-5-f0c8d00295d5@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 10:47:54 +0000
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

> The description of the boot memory regions does not mention the low
> memory region and claims there is always a region per node plus a global
> region, while the low memory and the global regions are not allocated
> when they would be empty.
>=20
> List all types of the boot memory regions and describe when they are not
> allocated.
>=20
> While on it, fix grammar and split the description of the regions size
> and of the CMA usage into separate paragraphs.
>=20
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-kho-bootme=
m-sizing-v3-0-f0c8d00295d5@kernel.org?part=3D5


