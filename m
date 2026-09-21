Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8302AC982ED
	for <kexec@archiver.kernel.org>; Mon, 21 Sep 2026 09:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iKFnnUVgMFXCyMZXDC0Gp9g2hFUBByCOSHmRiQGpkGs=; b=Yny6BMId04yebiVVk5DtTONCzc
	FLP39AXpnbrHW9PW9kALb8928E8SFSa3lnTSztu4evFb3u3OgT9zglDMxEBzL/iPcz3WZ/5eKNMm1
	w9EsoGrOSobiuu43JmclW6rJAtdbMzIIeZbaEWXNl/fACMzmI9yk9T1qR0T9vMheCcaN91aJXGzL/
	ZDZH6TRNUwU1jp27tLXxXLcoqiUQhOshNvcqv63PR/H3TZFFWI6/LDE++ajJWbzWpf7Rfm2A+Yp5L
	24x3SjMi3kI9IZ1jqKb44sR/6whbFLaj4R3koY8DjwNe+6qe3LiKs1b1mm90NLAA2br0Cjaey4nWJ
	1Ru4BWLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8adE-00000001Zfe-2lTE;
	Mon, 21 Sep 2026 09:48:16 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8a81-00000001Te6-2nKC;
	Mon, 21 Sep 2026 09:16:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6999B42004;
	Mon, 21 Sep 2026 09:16:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B4C1F00898;
	Mon, 21 Sep 2026 09:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789982161;
	bh=iKFnnUVgMFXCyMZXDC0Gp9g2hFUBByCOSHmRiQGpkGs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eHG0fA+GVBiImiZzlsuxCmiW4QIyTR/aPZvoP9v5NylyTbUhwz4qciulTNW5LXkXq
	 K3WKoRW+fr226xkxw7R8r5SnsneEjP6Axshr6u75njSZGCXcCVluZnG9xDRpyDY6xs
	 EFriL5emiLA/XLPMxq58s20ogoBPHi1s/Ak8FZ6OgYDuj1unhLvxtbQY/CLkUuDL3Q
	 1ZwP/YXZpcRKGPEnhufv0pbrNo41MXu7WUOt6ucbymZFWiH5nhO2OL77j+WD7zsECf
	 0lyezSqj6JCNikhjuCaXKWXmVNvuRoNz090YaolbMqD14eT8wEpe3E1pvpPf0p4jC7
	 dKFuz1EbnrY7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 08/14] LoongArch: kexec_file: Fix a modified_cmdline
 leak
To: maqianga@uniontech.com, dakr@kernel.org, kees@kernel.org, mingo@redhat.com, seanjc@google.com, gregkh@linuxfoundation.org, mpe@ellerman.id.au, driver-core@lists.linux.dev, palmer@rivosinc.com, chleroy@kernel.org, coxu@redhat.com, akpm@linux-foundation.org, piliu@redhat.com, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, mclapinski@google.com, robh@kernel.org, maddy@linux.ibm.com, hpa@zytor.com, ruirui.yang@linux.dev, bgwin@google.com, leitao@debian.org, catalin.marinas@arm.com, jbouron@amazon.com, npiggin@gmail.com, guodongtai@kylinos.cn, kai.huang@intel.com, sourabhjain@linux.ibm.com, bp@alien8.de, baoquan.he@linux.dev, pratyush@kernel.org, pasha.tatashin@soleen.com, chenhuacai@kernel.org, zhangtianyang@loongson.cn, ritesh.list@gmail.com, vishal.l.verma@intel.com, thuth@redhat.com, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, hbathini@linux.ibm.com, tglx@kernel.org, yeoreum.yun@arm.com, sshegde@linux.ibm.com, rppt@kernel.org, will@kernel.org, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, rafael@kernel.org, kernel@xen0n.name, me@linux.beauty, james.morse@arm.com, linux-arm-kernel@lists.infradead.org, dave.hansen@linux.intel.com, liukexin@kylinos.cn, graf@amazon.com, mark.rutland@arm.com, chao.gao@intel.com, takahiro.akashi@linaro.org, eric.devolder@oracle.com, tangyouling@kylinos.cn
Cc: ruanjinjie@huawei.com, kexec@lists.infradead.org
In-Reply-To: <20260921090450.807575-9-ruanjinjie@huawei.com>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
 <20260921090450.807575-9-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 09:15:57 +0000
Message-Id: <20260921091558.56B4C1F00898@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921090450.8075=
75-1-ruanjinjie@huawei.com?part=3D8


