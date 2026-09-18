Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8344C982E6
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NK4q4bMTc4NtuqUZq2p2ouZ93CvhS6B9qDA0XHB+AQs=; b=TBZqV2g+nfleCt6Zfefjugj6GM
	3EBG2Nqme39dLu59lAplByeMEoySXOPpQmi4BGmUVu9M1kRDxwylDxtuFxy4mqYPKVXIpLNswfNi3
	aDUJIzXW9lzxt+FMmkYaGRlmOBcNCCn9U1CZgpyHEzGFXVN8K9pj8yHFoDczAG9AEjyfK7kRAqeC7
	SdMMoOo/wp+YuHG0sMqAdNJ4LRhCDVuxtImaGVEOilU14H9TSZ51SC9FLzev/hQbDaV4Ujsa5/npw
	QeEWx7chPXTJpyWZBUP2s7Eqioc/p0xvjGXc20Xd6fIcBrkqM9Vdhet05GmvrYCeqmnlCbjcA8eIe
	hk/0usxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O4e-00000000N47-3Nu1;
	Sun, 20 Sep 2026 20:23:44 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7VgI-0000000E5Bz-2j0l;
	Fri, 18 Sep 2026 10:18:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 196A860A64;
	Fri, 18 Sep 2026 10:18:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A10E1F00898;
	Fri, 18 Sep 2026 10:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789726737;
	bh=NK4q4bMTc4NtuqUZq2p2ouZ93CvhS6B9qDA0XHB+AQs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nih+CgdhGnLO8TOeDlPBdKPirdBoHe0i3bMXikC3kG5yEMeDAdT/7gzT4yWuBpvZx
	 W7cUWDlxizNzUCQLwfXs94uynL6mjAM7ePcKxhgXkPT+1qBU4XiAVkZUxCID7DY2Jb
	 +goXUKIBVWZDUgSR4iPriXVvwYXN8d8X9H82/VSmmMSLI/OoaAUWelD4FsQaZZammh
	 eYyGUgPR2fj74PNv1XQ3/oKvNKleNUqhIx12OPwpZiHqNhqR9DXO1fQvv8HQ/XlO0M
	 vmZ3I07NIFGVT6o1Dcu0cuUd02YdMq7cV0HFTHOA46CJjQwBsUjh8NbSWls+LhVb5U
	 tjgTt00+qSZbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/17] LoongArch: kexec_file: Fix a modified_cmdline
 leak
To: rafael@kernel.org, mingo@redhat.com, leitao@debian.org, graf@amazon.com, ritesh.list@gmail.com, coxu@redhat.com, sshegde@linux.ibm.com, catalin.marinas@arm.com, bp@alien8.de, blum@kernel.org, chao.gao@intel.com, linuxppc-dev@lists.ozlabs.org, chenhuacai@kernel.org, jbouron@amazon.com, eric.devolder@oracle.com, palmer@rivosinc.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, hbathini@linux.ibm.com, rppt@kernel.org, james.morse@arm.com, will@kernel.org, maddy@linux.ibm.com, chleroy@kernel.org, dave.hansen@linux.intel.com, sourabhjain@linux.ibm.com, mpe@ellerman.id.au, baoquan.he@linux.dev, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, gshan@redhat.com, gregkh@linuxfoundation.org, lizhengyu3@huawei.com, adityag@linux.ibm.com, tglx@kernel.org, guodongtai@kylinos.cn, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, me@linux.beauty, hpa@zytor.com, x86@kernel.org, piliu@redhat.com, ardb@kernel.org, takahiro.akashi@linaro.org, npiggin@gmail.com, maqianga@uniontech.com, mclapinski@google.com, yeoreum.yun@arm.com, kernel@xen0n.name, vishal.l.verma@intel.com, bgwin@google.com, driver-core@lists.linux.dev, seanjc@google.com, kas@kernel.org, tangyouling@kylinos.cn, pasha.tatashin@soleen.com, zhangtianyang@loongson.cn, ruanjinjie@huawei.com, ruirui.yang@linux.dev, kees@kernel.org, thuth@redhat.com, linux-arm-kernel@lists.infradead.org, liukexin@kylinos.cn, dakr@kernel.org, pratyush@kernel.org, robh@kernel.org, mark.rutland@arm.com, loongarch@lists.linux.dev
Cc: kexec@lists.infradead.org
In-Reply-To: <20260918100442.3841135-9-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-9-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:18:54 +0000
Message-Id: <20260918101854.7A10E1F00898@smtp.kernel.org>
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

> load_other_segments() allocates modified_cmdline and stores it in
> image->arch.cmdline_ptr.  machine_kexec_prepare() then copies it to
> KEXEC_CMDLINE_ADDR and overwrites the pointer, so the heap buffer is
> leaked on every successful kexec_file_load().
>=20
> Free the buffer after the copy.
>=20
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: WANG Xuerui <kernel@xen0n.name>
> Cc: Kexin Liu <liukexin@kylinos.cn>
> Cc: Youling Tang <tangyouling@kylinos.cn>
> Cc: Qiang Ma <maqianga@uniontech.com>
> Cc: Tianyang Zhang <zhangtianyang@loongson.cn>
> Cc: George Guo <guodongtai@kylinos.cn>
> Cc: stable@vger.kernel.org
> Fixes: d162feec6b6e ("LoongArch: Add preparatory infrastructure for kexec=
_file")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918100442.3841=
135-1-ruanjinjie@huawei.com?part=3D8


