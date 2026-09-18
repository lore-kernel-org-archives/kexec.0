Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C36DC982F7
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VuJOT4kdOpRvZM5empbp0YF0BApQR/2NER1H6HyuVXU=; b=i6AQpaUozjJiBrVKoPKNeDgX2Y
	YFDvONOdABnLpA2vZIH1sM/qoZYFj5Glj0gBl/lYpDTo/Cb62/UqQBdqzdD1ShUZOW5yLXzgp0XVL
	A91D9VDHPojVGMRoEDY+1uM3XyH9mSex4WXCY0WtxGlN6WfKon0SbnuzaKhD7SJutMhGNF9/fuV5d
	vlnCvw3qinMY9rRD2euP+cAv0K27xipQf+udeqwdNxKyXj76PheTTZgm4aS20xRxcmlX98sVgiNLy
	ctjSUloX14fZ9lUfMsc2oIyniPGID6+mXF9ookndiIGwvywcnbyL+7vfqq5poJKJHfT/8Xwkv8YSX
	738FUB2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O4c-00000000Mv7-2B0N;
	Sun, 20 Sep 2026 20:23:42 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7VeI-0000000E50G-3nEz;
	Fri, 18 Sep 2026 10:16:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2DCF560A5F;
	Fri, 18 Sep 2026 10:16:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC741F000FF;
	Fri, 18 Sep 2026 10:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789726613;
	bh=VuJOT4kdOpRvZM5empbp0YF0BApQR/2NER1H6HyuVXU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i9JXfNnKptQjjq63WxDdIuBBUCCL146Poh1RSC+XdoWWB0Fy9dhH0a6kLZUmX1w+W
	 qF3REZ2mxGCNIiOaSwVwjNNaV6NjoRH0sNjvZWq3XRPs6dKW4AZDk1Yede6r8fqzyx
	 o80qLR6AMuSO9xrYinfK9dWCY6zzP/z7rF1NstRvN9oRwP7A4igRkbL4/CMivPIyT9
	 wnnCcsZ+tEz1MqTHyJ+d9y56CfkfVre+2Dy56b5WhLwcyAKGultFUGWzcdJ07WiKeU
	 rZjGFcwvdwgNrDGSmopMB7dJJ/e/9den7VyfEVj7fDrOGtONqMyz83JtmkWwNL2swS
	 Lx0epawLg3Kpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/17] arm64: kexec_file: Fix elf_headers memory leak
 in retry loop
To: maqianga@uniontech.com, dave.hansen@linux.intel.com, dakr@kernel.org, pratyush@kernel.org, vishal.l.verma@intel.com, mark.rutland@arm.com, hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, kernel@xen0n.name, mpe@ellerman.id.au, sourabhjain@linux.ibm.com, eric.devolder@oracle.com, linux-fsdevel@vger.kernel.org, gshan@redhat.com, x86@kernel.org, hpa@zytor.com, lizhengyu3@huawei.com, kees@kernel.org, adityag@linux.ibm.com, ruirui.yang@linux.dev, yeoreum.yun@arm.com, chao.gao@intel.com, ardb@kernel.org, piliu@redhat.com, graf@amazon.com, james.morse@arm.com, zhangtianyang@loongson.cn, tglx@kernel.org, will@kernel.org, rppt@kernel.org, rafael@kernel.org, pasha.tatashin@soleen.com, thuth@redhat.com, akpm@linux-foundation.org, blum@kernel.org, palmer@rivosinc.com, coxu@redhat.com, linux-arm-kernel@lists.infradead.org, chenhuacai@kernel.org, robh@kernel.org, seanjc@google.com, linux-kernel@vger.kernel.org, bp@alien8.de, takahiro.akashi@linaro.org, bgwin@google.com, maddy@linux.ibm.c
 om, linux-mm@kvack.org, liukexin@kylinos.cn, catalin.marinas@arm.com, chleroy@kernel.org, mingo@redhat.com, ruanjinjie@huawei.com, tangyouling@kylinos.cn, jbouron@amazon.com, ritesh.list@gmail.com, sshegde@linux.ibm.com, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, gregkh@linuxfoundation.org, leitao@debian.org, me@linux.beauty, baoquan.he@linux.dev, loongarch@lists.linux.dev, npiggin@gmail.com, kas@kernel.org, mclapinski@google.com, guodongtai@kylinos.cn, driver-core@lists.linux.dev
Cc: kexec@lists.infradead.org
In-Reply-To: <20260918100442.3841135-6-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-6-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:16:50 +0000
Message-Id: <20260918101650.9FC741F000FF@smtp.kernel.org>
X-Mailman-Approved-At: Sun, 20 Sep 2026 13:23:20 -0700
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918100442.3841=
135-1-ruanjinjie@huawei.com?part=3D5


