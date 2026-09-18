Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3E9C982D8
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ojRb2OtGZV+lNR54MP8W9kUbXEoKZ+Rzr9bvDWAKmSI=; b=Cr4CXEk8K98i706eSQjNMfMaSD
	K2PUp2TDRpp5Yg6vP8vehMQtVA7cYlR603jI7XWMfJaSfBi/1FVcnghRzidcEFYkZi1SjVFuIyOPH
	NUQbiXRJC/GFIekbaLLLkHa1D5n+HGXKGXXSUi+La09FplPsPI46oBw6qKD2HsAC758EYaWoYqx+D
	Leyr7VQlPiewffvX3f13/gu3AyET0xTOCJjGKBAlhiVFVDn/Qoinyw1EgVqMwX0LzxZyeI6E3rFwW
	khMeG8UrWhy1+0Pn7vu1pMHBuUc9M/KPEIk3A6GnHR7UPK4RXMbR0gvh44zcaE3H0AKdjxO+MDz3P
	6NNL1BPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O4f-00000000N5i-2W7h;
	Sun, 20 Sep 2026 20:23:45 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7ViM-0000000E5Ln-0vxD;
	Fri, 18 Sep 2026 10:21:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id AB4B043BDD;
	Fri, 18 Sep 2026 10:21:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482D31F00893;
	Fri, 18 Sep 2026 10:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789726865;
	bh=ojRb2OtGZV+lNR54MP8W9kUbXEoKZ+Rzr9bvDWAKmSI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VbhnGqJbr+ybtK3Fnwjub4nxRMAkKMpEzatb5UyqR56xMFB6wzCkyGzg4dZWPmT3+
	 X+snAKFCSsw9hS3uDDtXyaV+a120iBx6doKN2SXy7kWsE6Ghr43NePclsslWz3X5jO
	 umM+Y1oZRe63NELb54DdiEkz9d+zMmZueH0FDcyiLWVV9cdWUYTG7WaCOZvG2X/7g/
	 a9oPJYB+Dy64zxGyUYebphSZ5ylo5LJpeevfZI8VBPaG8K99ZpvTAK5Kx+JWQnO/hy
	 0N1qcxBpGbuzeUsqKEcZ7LzQMrQi37y/VFurlQHxRKvV4Yc12NiNYAuI+ZMxmxdW8s
	 JCL5q8jJo+Sfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/17] LoongArch: kexec_file: Fix elf_headers memory
 leak in retry loop
To: leitao@debian.org, seanjc@google.com, kees@kernel.org, thuth@redhat.com, tglx@kernel.org, loongarch@lists.linux.dev, will@kernel.org, hbathini@linux.ibm.com, rppt@kernel.org, akpm@linux-foundation.org, chao.gao@intel.com, hpa@zytor.com, guodongtai@kylinos.cn, takahiro.akashi@linaro.org, maddy@linux.ibm.com, pratyush@kernel.org, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, zhangtianyang@loongson.cn, lizhengyu3@huawei.com, blum@kernel.org, x86@kernel.org, eric.devolder@oracle.com, catalin.marinas@arm.com, ruirui.yang@linux.dev, me@linux.beauty, adityag@linux.ibm.com, ruanjinjie@huawei.com, vishal.l.verma@intel.com, mark.rutland@arm.com, sourabhjain@linux.ibm.com, linux-kernel@vger.kernel.org, rafael@kernel.org, chenhuacai@kernel.org, pasha.tatashin@soleen.com, palmer@rivosinc.com, ritesh.list@gmail.com, kernel@xen0n.name, robh@kernel.org, dakr@kernel.org, james.morse@arm.com, mingo@redhat.com, tangyouling@kylinos.cn, mclapinski@google.com, linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, jbouron@amazon.com, sshegde@linux.ibm.com, graf@amazon.com, bgwin@google.com, bp@alien8.de, linux-mm@kvack.org, chleroy@kernel.org, piliu@redhat.com, maqianga@uniontech.com, gshan@redhat.com, yeoreum.yun@arm.com, coxu@redhat.com, mpe@ellerman.id.au, dave.hansen@linux.intel.com, npiggin@gmail.com, baoquan.he@linux.dev, kas@ker
 nel.org, liukexin@kylinos.cn, ardb@kernel.org, driver-core@lists.linux.dev, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org
Cc: kexec@lists.infradead.org
In-Reply-To: <20260918100442.3841135-8-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-8-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:21:01 +0000
Message-Id: <20260918102102.482D31F00893@smtp.kernel.org>
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
> However, during a retry loop in efi_kexec_load(), a subsequent iteration
> will allocate a new buffer and overwrite image->elf_headers. This
> permanently leaks the stale memory from the previous iteration before
> the global cleanup can track it.
>=20
> Fix this by explicitly freeing the stale `image->elf_headers` buffer
> before assigning the newly allocated headers.
>=20
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: WANG Xuerui <kernel@xen0n.name>
> Cc: Youling Tang <tangyouling@kylinos.cn>
> Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Cc: Kees Cook <kees@kernel.org>
> Cc: stable@vger.kernel.org
> Link: https://sashiko.dev/#/patchset/20260729031235.2840255-1-ruanjinjie%=
40huawei.com
> Fixes: 55d990f0084c ("LoongArch: Add EFI binary support for kexec_file")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918100442.3841=
135-1-ruanjinjie@huawei.com?part=3D7


