Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15229C982EE
	for <kexec@archiver.kernel.org>; Mon, 21 Sep 2026 09:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3ZanDre/sxM7yOn9EPACCus3LOsx6cj95+yc4nBcgzI=; b=J0h0pE7nGG6bCzI/rWe8xDhQ1T
	g7ukDJnEL2AOsVYXp76jGJFjDlehc1lOeGLsGTcpvqZQYKZQ4mO3zNgFvzCoq7LkI+cOekglGUfZC
	DyEesObqvHIJhe9kBx3gk5MCxUDAXDQksM/WrNywHnmJO0/JWhQoTESVt91WII5o6cDI/mxMRNpGT
	+4Ta9Xjo4c3nRfT+leL4kH8qU3/FsRQBfps58D8hY/I/LbPSqJ2CJsgbHMrECYjb3LKREKyxMlE6O
	SEFxzPHNyNxyv2zmnj9mrsP0Cj+FxC9NsVlRNQxJsECjiSLPXxrOn7k7BR/2i51pViF/c0Gcg6jqK
	DwoXReow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8ad9-00000001Zb2-3xMV;
	Mon, 21 Sep 2026 09:48:11 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8a7E-00000001TX0-3mw0;
	Mon, 21 Sep 2026 09:15:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 964354029A;
	Mon, 21 Sep 2026 09:15:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A930B1F000FF;
	Mon, 21 Sep 2026 09:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789982112;
	bh=3ZanDre/sxM7yOn9EPACCus3LOsx6cj95+yc4nBcgzI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZOEN+RoDDK26gDP5B5Z9LlLZO1s1nCn5eg6mIuaCu6GgNZmdhLQxLNmwagQJw3jNZ
	 HSTQKCve+9oH2k8A8MzFqJ15CxKt8vEI7iKnmIVQDfJqq1n7HPsA2n8TLYeSCy0aiN
	 FpDbwb94QreklK9goP5shle0U5QXsF6FQ01poX7/gzwPVreCPhjjIvl7Uw9RSL93Iy
	 GF6JPlRgde+gm7ZRr0IwEGKaUN5B90anrRojkn+vTBJ4R+6PruEi9YQMY32D/IGpJo
	 29xGW3a7rZhzUio5PLTxY6Wlb6TkskdZxe2IUURQwsc33w61NyfOl8XPq/R3ZUEKk7
	 0Dcdsu9FyY3LA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/14] arm64: kexec_file: Fix elf_headers memory leak
 in retry loop
To: kees@kernel.org, eric.devolder@oracle.com, yeoreum.yun@arm.com, driver-core@lists.linux.dev, hbathini@linux.ibm.com, me@linux.beauty, rppt@kernel.org, jbouron@amazon.com, hpa@zytor.com, linux-arm-kernel@lists.infradead.org, dakr@kernel.org, maddy@linux.ibm.com, tangyouling@kylinos.cn, will@kernel.org, mark.rutland@arm.com, dave.hansen@linux.intel.com, sourabhjain@linux.ibm.com, catalin.marinas@arm.com, leitao@debian.org, vishal.l.verma@intel.com, bp@alien8.de, guodongtai@kylinos.cn, zhangtianyang@loongson.cn, loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, rafael@kernel.org, kai.huang@intel.com, mclapinski@google.com, piliu@redhat.com, sshegde@linux.ibm.com, thuth@redhat.com, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, coxu@redhat.com, linux-kernel@vger.kernel.org, x86@kernel.org, chenhuacai@kernel.org, chao.gao@intel.com, ruirui.yang@linux.dev, bgwin@google.com, takahiro.akashi@linaro.org, palmer@rivosinc.com, seanjc@google.com, chleroy@kernel.org, liukexin@kylinos.cn, pratyush@kernel.org, kernel@xen0n.name, james.morse@arm.com, maqianga@uniontech.com, npiggin@gmail.com, baoquan.he@linux.dev, gregkh@linuxfoundation.org, akpm@linux-foundation.org, ritesh.list@gmail.com, graf@amazon.com, tglx@kernel.org, mingo@redhat.com, robh@kernel.org, mpe@ellerman.id.au, pasha.tatashin@soleen.com
Cc: ruanjinjie@huawei.com, kexec@lists.infradead.org
In-Reply-To: <20260921090450.807575-6-ruanjinjie@huawei.com>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
 <20260921090450.807575-6-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 09:15:09 +0000
Message-Id: <20260921091509.A930B1F000FF@smtp.kernel.org>
X-Mailman-Approved-At: Mon, 21 Sep 2026 02:47:56 -0700
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

> If load_other_segments() fails after image->elf_headers is assigned,
> the memory lifecycle is safely managed by the global kimage object
> and will be freed in arch_kimage_file_post_load_cleanup().
>=20
> However, during a retry loop in image_load(), a subsequent iteration
> will allocate a new buffer and overwrite image->elf_headers. This
> permanently leaks the stale memory from the previous iteration before
> the global cleanup can track it.
>=20
> Fix this by explicitly freeing the stale `image->elf_headers` buffer
> before assigning the newly allocated headers.
>=20
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Breno Leitao <leitao@debian.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Yeoreum Yun <yeoreum.yun@arm.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: stable@vger.kernel.org
> Fixes: 108aa503657e ("arm64: kexec_file: try more regions if loading segm=
ents fails")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921090450.8075=
75-1-ruanjinjie@huawei.com?part=3D5


