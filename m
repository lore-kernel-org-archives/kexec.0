Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C78E606A31D
	for <kexec@archiver.kernel.org>; Fri, 23 Oct 2026 08:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=QNYt1d4W;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F/P3+rla
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=G07pFDm6HFgRZNT2km3sufOLBA53KCkDhkYdSxY+Ou4=; b=QNYt1d4WAI3rs99K3mzqLVgG6C
	671KPyD02UX2UUtDN1N9bY3lxuhQVFKBs0WHBninFYVrdajxgvksAP17plxzNdMjGtaTTq7SJSD8J
	ca8RpH/DWfjXQqJaI8dCfIzO2+o9fKmmqXnF2kAcX2qOjIwmHLUjMMILt5Xh6ZEIN4vIY3NFOIdJR
	g1T0H1uKVDOgXyq6yKVRtuI76P/DUhrqskeAjzEnp03gSm2p91Bqb5ek6BcJugTzSFxzwhsRkbeqO
	HdRP7XMx0MniLRHWeuWvQn3b3T1wdon3oH67FXiKvS8+iWdrGwzvRHoWJ0OVASiJTXkYk8kl22pWB
	Spxfh6HQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKAG6-0000000FrZu-3efB;
	Fri, 23 Oct 2026 08:04:14 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKAG6-0000000FrZf-22e3
	for kexec@lists.infradead.org;
	Fri, 23 Oct 2026 08:04:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 02979415F5;
	Fri, 23 Oct 2026 08:04:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF611F01825;
	Fri, 23 Oct 2026 08:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792742653;
	bh=G07pFDm6HFgRZNT2km3sufOLBA53KCkDhkYdSxY+Ou4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F/P3+rlaAon2NR8ZsTr4wJvcGTR0q1lP0bYhxnZzcbiT8i7KuEDimv3YGTGgbmyB2
	 jtY6f+pcZ+fSEBE3hgp8gJkoq6zCmnQy31E4CiTvvXxYL165980yeAoZLFwlRu9WkK
	 VS9EBGDsnUtviHARK7iVCDe5QvEWcvMEWVFSfUFpSYHItGGEaf/7tN+ZQGjciWXPWq
	 y3ReEkUqsr8/YXQ3x5vWJPKX7VwZ9lL2e6/JNfmQVS6SfZFd/mTR6esccDhj6kTjfO
	 6WG4PZh1lrcPsLPrKR2Xc3LJxuNn+bDbN6UEqn+ugXJtOKazVttOrt7dQ+c9A6aDJ7
	 Iw/BTiTYsDRQw==
Message-ID: <sashiko-outbox-182469@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] kexec_core: Clear the unused part of CMA segments
To: "Han Gao" <gaohan@iscas.ac.cn>, "Paul Walmsley" <pjw@kernel.org>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre
 Ghiti" <alex@ghiti.fr>, "Nathan Chancellor" <nathan@kernel.org>, "Nick
 Desaulniers" <ndesaulniers@google.com>, "Bill Wendling" <morbo@google.com>, "Justin
 Stitt" <justinstitt@google.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Baoquan
 He" <baoquan.he@linux.dev>, "Mike Rapoport" <rppt@kernel.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Yao
 Zi" <me@ziyao.cc>
Cc: "Han Gao" <rabenda.cn@gmail.com>, kexec@lists.infradead.org
In-Reply-To: <20261023-riscv-kexec-cma-fixes-v1-4-825b90ea23c4@iscas.ac.cn>
References: <20261023-riscv-kexec-cma-fixes-v1-0-825b90ea23c4@iscas.ac.cn>
 <20261023-riscv-kexec-cma-fixes-v1-4-825b90ea23c4@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 08:04:12 +0000
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> From: Han Gao <gaohan@iscas.ac.cn>
>=20
> kimage_load_cma_segment() copies the source data into pages that are not
> cleared, but zeroes nothing after it: the final memset() runs once the
> loop has consumed all of memsz. The tail of the last source page and
> every page beyond bufsz keep stale data, while the purgatory digest
> covers them as zeroes.
>=20
> A kexec_file reboot then stops in purgatory on a digest mismatch, for
> instance when the DTB lands in a reused CMA page.
>=20
> Zero the remainder of each page instead.
>=20
> Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-riscv-kexe=
c-cma-fixes-v1-0-825b90ea23c4@iscas.ac.cn?part=3D4


