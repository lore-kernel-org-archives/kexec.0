Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF54606A89F
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 10:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=POvkzBGQ;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hDkP6biZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=oFKR9yNEKumpUkj+R+V7Il5eKMS7QYAR0aRlqbeK+Xs=; b=POvkzBGQEfCJdls1r91swagTSh
	SrMGZldNwaSLjaAiqc98I4bj+og7RkckHWt72EMpzZTvUygpABGm7g/X32/6ZipckqgDJWobhVnLK
	ipZKDOuwRxpQkrSdLMBoclSxD594mQ6TduH2Og2B4r8enKRLLTTrIzgdYt2JslN2M3HCKOS5P3GwJ
	ANq1EE84pekgndfhL9gInhsvU2YdloHgCL5/++8Fe0Dkp0tgQzQdPI1H8qKI6hBDYocWTT26oKK4w
	ValJJFYvirfhpEmKVQ/cYDb07ox3jbSzirf2jjbSSfEo2uc/ec1qqda+bxlDsfCOkn+ltEEUxW7RW
	wPTU1PzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRSLW-00000009aMC-1Gct;
	Thu, 12 Nov 2026 10:47:58 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRSLR-00000009aKp-3851
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 10:47:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 104DE6122A;
	Thu, 12 Nov 2026 10:47:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126BE1F00A06;
	Thu, 12 Nov 2026 10:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794480472;
	bh=oFKR9yNEKumpUkj+R+V7Il5eKMS7QYAR0aRlqbeK+Xs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hDkP6biZ0VPsL6SM5KJYZ/0cpmg3Wl0D3r9JZfIRlSu4jmwoW9X61fmK65B+XBQJ/
	 YNnGU21TUV+VPYescsXRXva/bFSHK+Kgv/PEz/IIyJ3gkiIKqOVwwJQO1p9IAEdNe3
	 NRVlJAvrdyEInIaoYNJGHXKHxFxrxL1NnzIBxiW/o1GZh6w7aHTYq1/Ozu3kP/cvQz
	 aCjdVS3cuOdNZKg+5GKrcP+Ts5EQ8Dj5lUsf/n8QqJPnElCdbeQfkxsDHnveUhzTZw
	 EO/9wteU0lvOQ5vRvn7D8xVVqmgtWr2MBw0GcycwglzR5VBATAtecwui4n3FEbCqyE
	 iEkyiXxRTcZ0Q==
Message-ID: <sashiko-outbox-210971@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/5] kho: skip zero-sized lowmem and global bootmem
 areas
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>, "Jonathan
 Corbet" <corbet@lwn.net>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pratyush
 Yadav" <pratyush@kernel.org>
Cc: "Alexander Graf" <graf@amazon.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Chen
 Pei" <cp0613@linux.alibaba.com>, "George Guo" <guodongtai@kylinos.cn>, "Kexin
 Liu" <liukexin@kylinos.cn>, "Randy Dunlap" <rdunlap@infradead.org>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Sourabh Jain" <sourabhjain@linux.ibm.com>, kexec@lists.infradead.org, "Jose
 A. Perez de Azpillaga" <azpijr@gmail.com>, "Mukesh Pilaniya" <mpilaniy@redhat.com>
In-Reply-To: <20261112-kho-bootmem-sizing-v3-3-f0c8d00295d5@kernel.org>
References: <20261112-kho-bootmem-sizing-v3-0-f0c8d00295d5@kernel.org>
 <20261112-kho-bootmem-sizing-v3-3-f0c8d00295d5@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 10:47:51 +0000
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

> The lowmem and the global bootmem areas can have zero size, for example
> when none or all of the memory is below ARCH_LOW_ADDRESS_LIMIT, or when
> either of those areas is explicitly set to zero with kho_bootmem=3D.
>=20
> For a zero-sized allocation memblock returns an address without reserving
> anything, and that empty area is recorded in kho_bootmem. If there is no
> memory below ARCH_LOW_ADDRESS_LIMIT, allocation of the empty lowmem area
> fails and KHO gets disabled.
>=20
> Extract a helper that checks for zero size and allocates memory from
> memblock, and use it to skip empty areas the same way as empty per-node
> areas are skipped.
>=20
> Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
> Reported-by: Chen Pei <cp0613@linux.alibaba.com>
> Closes: https://lore.kernel.org/all/20261026131851.9942-1-cp0613@linux.al=
ibaba.com
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
> Reviewed-by: Mukesh Pilaniya <mpilaniy@redhat.com>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-kho-bootme=
m-sizing-v3-0-f0c8d00295d5@kernel.org?part=3D3


