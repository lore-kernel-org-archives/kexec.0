Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6A4606A328
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 08:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FiZZ/NAb;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kna3JVVw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=VaZhfXTmLjhwqCHtCLPIuohnj/qES/J9mc/nqkBvXyM=; b=FiZZ/NAbuolj42fyb9898pjCtq
	kbL6j/eLemKdnKj0KUrLp2RprArtrMpx3VED2fbUesT9snxhwe5OYeiZsnEh4piXk3Vr5nYk6LEaV
	Bd19Pj5pQEpQllA6xeoAhgi7tYnA8fsN/uaq/6u4J4UJ4mRq17h6NqEc/tdcchg80FB5J5YuUaVUb
	ADrZQK6/lxwKtTvBnN7Wm1knSYHf8woLQci5OMfbs04cSWoNL6W+CjsSx4I+CF2M0nWTEtzMVpm7Z
	IVawa72nZq0UUCw2mXXyf+J0FhuE8hcutpiEPXKT+9AzFhw410xfhO4YZYlnRTYdbKOOje9WYHwUJ
	UrHUfiqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOW4k-00000004edv-0Php;
	Wed, 04 Nov 2026 08:10:30 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOW4g-00000004eao-0Xql
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 08:10:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D643D43C83;
	Wed,  4 Nov 2026 08:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C011F00A15;
	Wed,  4 Nov 2026 08:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793779825;
	bh=VaZhfXTmLjhwqCHtCLPIuohnj/qES/J9mc/nqkBvXyM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kna3JVVwClv9e5zwkerb7reM8DP1e9M7yxQ2YJ+AwDlkfKGhKhC3QFN6RwGjFZWv6
	 36lqzCpVOhpqYUbFxt/J5qbMdm2BqliDg6FJrB9QzVNnBaMGV8dyVJb3WA50LnouB9
	 /TeXPvdkKjlyOSq2QPGSOjOs+4ies+fpGQVjWn21wO0/Drdc85pC8Hq8AgkWtyLk05
	 MXretq5F/sLoCdcxlmm5jyzjGkvBzOzapw8GzmVQnBBeHE/0H7iQbzoQGsMfVDCh0R
	 jBzFowXTTgTWs4BAn+3pFzNVzj1HA9UzpyFANLUf8MFND8aDoM9u5dKkRAo0mJ77T+
	 izJba5GOpAv4g==
Message-ID: <sashiko-outbox-196858@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] selftests: kho: Add riscv support
To: "Chen Pei" <cp0613@linux.alibaba.com>, pjw@kernel.org, palmer@dabbelt.com, alex@ghiti.fr, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, graf@amazon.com, shuah@kernel.org
Cc: guoren@kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261103080926.2079-5-cp0613@linux.alibaba.com>
References: <20261103080926.2079-1-cp0613@linux.alibaba.com>
 <20261103080926.2079-5-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 08:10:24 +0000
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

> Teach the KHO vmtest runner about riscv64: map the target to ARCH
> riscv and describe the QEMU virt machine, the kernel image and its
> console -- a 16550A port probed from the device tree on virt, hence
> the SERIAL_8250{,_CONSOLE} and SERIAL_OF_PLATFORM symbols.  Also
> select CONFIG_SPARSEMEM_MANUAL: the runner requires
> CONFIG_DEFERRED_STRUCT_PAGE_INIT, which depends on SPARSEMEM, while
> riscv falls back to FLATMEM (no ARCH_SPARSEMEM_DEFAULT), so without
> it the test would just be skipped.
>=20
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103080926.2079=
-1-cp0613@linux.alibaba.com?part=3D4


