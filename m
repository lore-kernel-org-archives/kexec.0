Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3693C98310
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iiUFRlHhVLGHO4P1JeUzTqnMBZGqjCg6ljFaVKDtmKU=; b=rhmcZ3JHbY+g4BeFYZpglIox7R
	LXDtkxpfzpLq3FA2/sMVakIhWT6jHtzIUbSOo0/Zn8NLDlUaCX8k8dar6RN/ywc5g1fCvPB2Eo5Jc
	VefNoOczF4sX2+v1rdzOndzKaH7IXgBzwqq2Iz9ke2FRZyudHHok6fPNODvn0bi1ajEg7FgVkgtD7
	1q6zXcTRLBCzKSX3t6Ke11m4C3v9SxYcxlhTN6F1Cl2WqPcUokT6Vt83Uc53Rd8w8lTej5FPanI93
	WioIGdznCXzcAUNQtwJFe+b9wPAg8vzghNQVmmoJgiVpu2yH5dcCf886OlvJHzUNmFNzWxH0QY3Ea
	4cpY+iBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O4X-00000000Ml0-3WFA;
	Sun, 20 Sep 2026 20:23:37 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7Vcp-0000000E4go-1SEV;
	Fri, 18 Sep 2026 10:15:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C2E2F41B02;
	Fri, 18 Sep 2026 10:15:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48821F000FF;
	Fri, 18 Sep 2026 10:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789726522;
	bh=iiUFRlHhVLGHO4P1JeUzTqnMBZGqjCg6ljFaVKDtmKU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CYMe2VxQKqjM48Qh1JiWT2P3UEJVuCac8ysLzJ+dZag32Ft9bAVcpGOMZ4HScYKSA
	 LrzLpuhoEMI3GtAYTsLW4jh/gRtnUoW+N9rRyYlYOyTXKJIrjz1QkFNSAmTri9KxtQ
	 YgAizPYMs6Pk+zAZ7x1uzNN3yUFr4LYNxPNrUJBDLylaSStamwvu6mgyHmTx6JLyky
	 SPUYmfalqSRbW2mY7QLXGTOAMq7KZrFu0mnGpoTqq6Cjx1Umnw5Hk54MIt5dBLGeyO
	 rCce++XRc1mltvKKrrut+TtgQ5n+bH85UTxblml2GEicEU8TJBSTEJtZaIOC4yTjcM
	 xr7wJo3WI5ZMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/17] arm64: kexec_file: Fix CMA page leaks in
 segment placement retry loops
To: ruanjinjie@huawei.com, graf@amazon.com, gshan@redhat.com, pasha.tatashin@soleen.com, catalin.marinas@arm.com, tglx@kernel.org, pratyush@kernel.org, ruirui.yang@linux.dev, linux-arm-kernel@lists.infradead.org, bgwin@google.com, palmer@rivosinc.com, mpe@ellerman.id.au, hbathini@linux.ibm.com, hpa@zytor.com, sourabhjain@linux.ibm.com, robh@kernel.org, adityag@linux.ibm.com, zhangtianyang@loongson.cn, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, guodongtai@kylinos.cn, linux-kernel@vger.kernel.org, linux-mm@kvack.org, me@linux.beauty, x86@kernel.org, ritesh.list@gmail.com, eric.devolder@oracle.com, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, blum@kernel.org, coxu@redhat.com, rafael@kernel.org, jbouron@amazon.com, rppt@kernel.org, tangyouling@kylinos.cn, maqianga@uniontech.com, sshegde@linux.ibm.com, kernel@xen0n.name, dakr@kernel.org, thuth@redhat.com, seanjc@google.com, npiggin@gmail.com, vishal.l.verma@intel.com, chao.gao@intel.com, liukexin@kylinos.cn, piliu@redhat.com, linuxppc-dev@lists.ozlabs.org, takahiro.akashi@linaro.org, kees@kernel.org, baoquan.he@linux.dev, james.morse@arm.com, yeoreum.yun@arm.com, dave.hansen@linux.intel.com, driver-core@lists.linux.dev, ardb@kernel.org, gregkh@linuxfoundation.org, leitao@debian.org, chenhuacai@kernel.org, kas@kernel.org, loongarch@lists.linux.dev, mclapinski@google.com, bp@alien8.de, lizhengyu3@huawei.com, mingo@redhat.com, will@kernel.org, mark.rutland@arm.com, maddy@linux.ibm.com, chleroy@kernel.org
Cc: kexec@lists.infradead.org
In-Reply-To: <20260918100442.3841135-5-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-5-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:15:18 +0000
Message-Id: <20260918101518.D48821F000FF@smtp.kernel.org>
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

> During kexec image placement retry loops, any midway failure causes
> the loader to truncate `image->nr_segments` back to its initial state
> to purge the failed segments.
>=20
> However, this truncation introduces a memory leak. The CMA pages
> allocated via kexec_add_buffer() during the failed attempt are tracked
> in the `image->segment_cma` array. Because the subsequent cleanup paths
> only iterate up to the truncated `nr_segments` boundary, these allocated
> CMA pages outside the new boundary are permanently leaked.
>=20
> Fix this by explicitly releasing the associated CMA buffers in
> the failure paths before `image->nr_segments` is reduced.
>=20
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Breno Leitao <leitao@debian.org>
> Cc: Pratyush Yadav <pratyush@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Yeoreum Yun <yeoreum.yun@arm.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: stable@vger.kernel.org
> Fixes: 07d24902977e4 ("kexec: enable CMA based contiguous allocation")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918100442.3841=
135-1-ruanjinjie@huawei.com?part=3D4


