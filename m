Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4081606A31A
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 13:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=IovjD5sH;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XvZ1ThUx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=zmBU/BalInOhBYK/tDt+bnfp+LN03MxL8kvPERCRG9Y=; b=IovjD5sHnjh0GbM22M2UYlx8Rs
	KBpdCG01BRB2AngpJQE5SbeUiOCymxjE0Zqpcxlw7+sgBGPJCboIrO3bKiLDlploTYzEQD2Yyjbq3
	PB/Sb+4dn+FbQvtfdRjnXUhRjBDutwNUZIVQIx/rqTWQwSWvD7GPY33g+k1GPjbDi1U6cwowmg4O5
	vJMnqd+tKXghAsVM6/16JUTjoWO5vbEfEE527G15wn9vmZjNDEUPC162zRDP8YiY/ckqzplUmdkYR
	G1EG5+oVI29n6DIkhHeJAv6MXk3tDNVhg0OR/fhFhpaJY7p34NibzfF9WJNXHLTiy5JTbjEQlPsNK
	S9LpToTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLKfU-00000002asi-2TvF;
	Mon, 26 Oct 2026 13:23:16 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLKfT-00000002asY-3Cqd
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 13:23:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B3FC1601FB;
	Mon, 26 Oct 2026 13:23:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253901F01825;
	Mon, 26 Oct 2026 13:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793020994;
	bh=zmBU/BalInOhBYK/tDt+bnfp+LN03MxL8kvPERCRG9Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XvZ1ThUxilPhbR6A9DTH9rs2b8HmanQpYpEjiczA2X+XCY2Z2KUvEFI1tDio3If6l
	 4C1UT7gQzd/CSfe7gCTSBEPJUAtCptx9gQ0J654qScRW3fWcLZjZbjetoXJL/c1XTO
	 5T25Ryz+eFkb4dflzrMKz3fOUmYlg0g4pPbGBgJtryRjVPMjm+y210HivwAt4AdtCf
	 9eehk304F0YLoS0x2N00FCabWXjaTWuN9z1qzaduChTjU51E/Uss/8ZWctISGIVrOE
	 q5BkUnAYw9LHWY8MLXqFtCWXbEEIb+tORM+sWupx4qYEjd9rXUB4BcNFn2sOKor0Ig
	 SrTF/OS7Qy0yQ==
Message-ID: <sashiko-outbox-185302@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] kho: Skip zero-sized bootmem areas
To: "Chen Pei" <cp0613@linux.alibaba.com>, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, graf@amazon.com
Cc: kexec@lists.infradead.org
In-Reply-To: <20261026131851.9942-1-cp0613@linux.alibaba.com>
References: <20261026131851.9942-1-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 13:23:13 +0000
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

> The lowmem and the global bootmem area are reserved unconditionally,
> while the per-node loop below already skips nodes whose size works out
> to 0. Either can legitimately be 0: the global size is the scaled total
> minus the lowmem one, so it is 0 whenever all measured reservations fit
> below ARCH_LOW_ADDRESS_LIMIT.
>=20
> Reserving 0 bytes still succeeds, so an area covering nothing gets
> recorded with a valid address. That is not neutral:
> kho_bootmem_overlap() reports an overlap for any request straddling
> that address, and memblock_alloc_hugetlb() aligns a request to its page
> size, so a 1G hugetlb allocation retries a free candidate on account of
> an area that holds nothing.
>=20
> A machine whose memory all starts at or above ARCH_LOW_ADDRESS_LIMIT
> hits the other side of the same code: the lowmem size is 0, the range
> below the limit is empty, the allocation fails and KHO is disabled
> although no lowmem area was needed.
>=20
> Skip a zero-sized area instead, as the per-node loop does. The
> descriptor count stays consistent, as kho_populate() derives it from
> the segment length that kho_fill_kimage() serialises.
>=20
> Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026131851.9942=
-1-cp0613@linux.alibaba.com?part=3D1


