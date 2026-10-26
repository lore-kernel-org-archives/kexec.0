Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7E7606A31A
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 09:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=oEcD08rn;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SZU9tgBz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=XuduLsloQFc6TYsn8sdkaRcAeMhj1i1WdulR5UvSCbs=; b=oEcD08rnB4x8Ppya3lNPDerSvm
	X/ixqeX2yCJ0DMunt1tWrhO3SyIhyHbrWzXRkX2ajpcgzfFnhJ80649EZVLXDa0lNXxrmGizDKF2w
	pxy1BX9kZsvkfl2qlLMB6BoJ7zrVE2YlL82RoaEm2FS1BJ/LiM9GG2WmRVuUYGkszf7fWy2Cm8EGc
	JkEYA9ldBD9MjyymeDI72y1kRLd+APXIcp6WIW787IzXdM2DYpWeM+5JK96qBD0UGlQmX037oe6HC
	PCljG69BfhqLDy6jtVNdSQBuzaI/UA/DVBCL8yIP3ciDzzDOQSqxBbWOoNPp9XHAWyuq7RdcoTLgP
	54BfXNoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLH4C-000000024ls-39Nx;
	Mon, 26 Oct 2026 09:32:32 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLH4A-000000024lX-2PIi
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 09:32:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 81F39600DA;
	Mon, 26 Oct 2026 09:32:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87E21F031E5;
	Mon, 26 Oct 2026 09:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793007149;
	bh=XuduLsloQFc6TYsn8sdkaRcAeMhj1i1WdulR5UvSCbs=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=SZU9tgBz3+EpmjrS1QkE4Pm7DKbvFv/PPdYP34eg3X+VkJDq06smiABU1pRj8JwC8
	 r+vSam9x4p30pEw6pZ8TjpTG0yuiOb86cge7qAmhXt2ctrxuZRoVg4yV8HfQXeY/hQ
	 bPyYU7NVhsNfudWxv24SF7do29CstdmBw5O3Y7mhLb5czC8YCoREHojrZbFRNgZ8Ek
	 w0V+l9y5tvEVFeEqow8MjrcRR5Hf87ukyfY4iOz2doY+rqJudSEGPU92aoD8VvBBJL
	 uIpz7IngYjeYVFPIShun/1+1wZuTCCXzQHAOmDPj7t30kkGrjHnmlwBmTzMArElFEi
	 5FCXUEWel1pcA==
Message-ID: <sashiko-outbox-184799@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 01/15] arm64: kexec_file: Stop using the Image
 text_offset
To: "Jinjie Ruan" <ruanjinjie@huawei.com>, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, thuth@redhat.com, leitao@debian.org, yeoreum.yun@arm.com, robh@kernel.org, sourabhjain@linux.ibm.com, kees@kernel.org, coiby.xu@gmail.com, Yeking@Red54.com, tangyouling@kylinos.cn, maqianga@uniontech.com, zhangtianyang@loongson.cn, guodongtai@kylinos.cn, blum@kernel.org, adityag@linux.ibm.com, hui.wang@canonical.com, sohammetha01@gmail.com, guoren@kernel.org, gaohan@iscas.ac.cn, kai.huang@intel.com, kas@kernel.org, vishal.l.verma@intel.co
 m, piliu@redhat.com, jbouron@amazon.com, mclapinski@google.com, me@linux.beauty, graf@amazon.com, bgwin@google.com, x86@kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261026075201.699550-2-ruanjinjie@huawei.com>
References: <20261026075201.699550-1-ruanjinjie@huawei.com>
 <20261026075201.699550-2-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 09:32:26 +0000
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
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> image_load() adds text_offset to kernel_segment->mem and subtracts it
> from kernel_segment->memsz.  For CMA backed segments this breaks the
> load path: the payload is copied to page_address(cma), which is the CMA
> base, while image->start is set to the adjusted address, so kexec jumps
> into the middle of the kernel.  kimage_map_segment() has the same
> mismatch when a segment has been moved.
>=20
> The adjusted memsz also breaks the release path: the CMA pages are
> freed using segment->memsz >> PAGE_SHIFT, which is fewer than were
> allocated, leaking the tail of the allocation.
>=20
> Since commit 751c263bb74f ("arm64: remove TEXT_OFFSET randomization")
> TEXT_OFFSET is always zero.  This has been upstream since v5.8, so no
> LTS kernel carries a non-zero text_offset.  Drop the adjustment and
> reject images with a non-zero value instead of booting them from a
> wrong address.  With the adjustment gone, segments stay at their CMA
> base and the release size matches the allocation.
>=20
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Link: https://lore.kernel.org/all/20260921090450.807575-2-ruanjinjie@huaw=
ei.com/
> Link: https://lore.kernel.org/all/20260921090450.807575-3-ruanjinjie@huaw=
ei.com/
> Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
> Suggested-by: Mike Rapoport <rppt@kernel.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026075201.6995=
50-1-ruanjinjie@huawei.com?part=3D1


