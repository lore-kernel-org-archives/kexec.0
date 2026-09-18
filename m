Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F2D1C982F0
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w5fb2OONy/GtAEA2nh09Nc6VmArU5Yo8QzF94WDuj7Q=; b=Xu61ZfZnQ4vur3KBk/q80jOT+A
	zYXui5M1ukrOB1b871WRT2sg3FshCkOnLT8XHrH6DYAzYT/MDwk2yjszQKcjtPuVZpUkroEJM6QlF
	Rsj/vK3Pp6sAOt1tzyMOCRRSUyB12qe3nSeFCNvhgy85KViqWosVKo6UiwuAvxd4DOUFEQWwr1cGr
	Jo7AVFLZ4btdFaz6kohn3V3CWlRPriyZ32fQM5f0f1it1psyG2ykRfzwgDxTZyxMoOPwWDOiEd5Pe
	kEyMEBeXk6IihVELsfL05H258i2QpciuCyqggUSMxAofKoC7wCxIZDlwt4+KSuaPG0trOHb6VBGPx
	GGOVvW8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O4e-00000000N2P-1B6z;
	Sun, 20 Sep 2026 20:23:44 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7VgE-0000000E5BA-14no;
	Fri, 18 Sep 2026 10:18:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 02C8C417C9;
	Fri, 18 Sep 2026 10:18:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1441F000FF;
	Fri, 18 Sep 2026 10:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789726733;
	bh=w5fb2OONy/GtAEA2nh09Nc6VmArU5Yo8QzF94WDuj7Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lj1qm4nuzvY02T7ZQm88v8594RzQxLp2GRkXbWgVVtVBvfJ+6goLRgyhIpzhTJXQZ
	 2pCDF8LvVM9fJ6fKY4+uc/wQedLYCLDrjQbRopgkTtwyv4NIZXDsJsBsWAeToGhILW
	 qd7/SMXEZaj32E8uUi5oBjPfqyGM9+5tnt3G7yuecWX/qsPGerXYb2JIpM5s946iF7
	 yX0r6HiqXBjOBn9Vf8OIhbAyKlBkfCZ5xjd2UdjefGRfUDGraENXigs62wTGvXo/Nl
	 LkzE83NwKAHUJdQRZdZ5u09Z6Rm8qLlOmfxoay4Us/G2o7l2JK4cU7+i/D/m+wP5MR
	 vk5oADV1Jc8tA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/17] kexec: Extract kexec_free_segment_cma() from
 kimage_free_cma()
To: x86@kernel.org, me@linux.beauty, vishal.l.verma@intel.com, npiggin@gmail.com, sourabhjain@linux.ibm.com, lizhengyu3@huawei.com, dakr@kernel.org, blum@kernel.org, linux-mm@kvack.org, dave.hansen@linux.intel.com, eric.devolder@oracle.com, adityag@linux.ibm.com, akpm@linux-foundation.org, will@kernel.org, takahiro.akashi@linaro.org, bgwin@google.com, catalin.marinas@arm.com, coxu@redhat.com, zhangtianyang@loongson.cn, driver-core@lists.linux.dev, kernel@xen0n.name, kees@kernel.org, hpa@zytor.com, kas@kernel.org, seanjc@google.com, linux-kernel@vger.kernel.org, mingo@redhat.com, ritesh.list@gmail.com, sshegde@linux.ibm.com, ruirui.yang@linux.dev, jbouron@amazon.com, leitao@debian.org, tglx@kernel.org, chenhuacai@kernel.org, hbathini@linux.ibm.com, james.morse@arm.com, mclapinski@google.com, palmer@rivosinc.com, ruanjinjie@huawei.com, linux-arm-kernel@lists.infradead.org, robh@kernel.org, linux-fsdevel@vger.kernel.org, maqianga@uniontech.com, gshan@redhat.com, chleroy@kernel.org, liuk
 exin@kylinos.cn, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, mpe@ellerman.id.au, pratyush@kernel.org, ardb@kernel.org, piliu@redhat.com, maddy@linux.ibm.com, yeoreum.yun@arm.com, loongarch@lists.linux.dev, baoquan.he@linux.dev, mark.rutland@arm.com, rppt@kernel.org, linuxppc-dev@lists.ozlabs.org, gregkh@linuxfoundation.org, rafael@kernel.org, chao.gao@intel.com, graf@amazon.com, thuth@redhat.com, guodongtai@kylinos.cn, bp@alien8.de, pasha.tatashin@soleen.com, tangyouling@kylinos.cn
Cc: kexec@lists.infradead.org
In-Reply-To: <20260918100442.3841135-4-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-4-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:18:49 +0000
Message-Id: <20260918101850.7E1441F000FF@smtp.kernel.org>
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

> kimage_free_cma() relies on image->nr_segments to iterate over segments.
> When an architecture loader (e.g., arm64) truncates nr_segments on a
> mid-way failure, CMA pages allocated beyond the new boundary become
> unreachable, causing silent memory leaks.
>=20
> Extract the per-segment freeing logic into the exported helper
> kexec_free_segment_cma(), so that architecture loaders can release
> individual segments before nr_segments is truncated. Refactor
> kimage_free_cma() to loop over the new helper, preserving existing
> behavior.
>=20
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Pratyush Yadav <pratyush@kernel.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918100442.3841=
135-1-ruanjinjie@huawei.com?part=3D3


