Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B328EC982DE
	for <kexec@archiver.kernel.org>; Mon, 21 Sep 2026 09:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ypk197u83QsJkKLOBorgGsgBYWL8I8pOcxYcooVQIRs=; b=DW0arZV9W9lqtoLfYrrw3vf6fb
	5BLcfR8/ZmZxgnve+CUyUnYhI/50JNRm5sEsvmnFFsG+1+rZydzDlfpMmCh65kBqq/Ywp2wdO1lHT
	JSe71AcWKbzIyzUaMd8x9qX3sJAbHQu6kUI3DPvNBT4rijPtfH15F7Ph09yps9quQGBnIJSSTr/ha
	rmmj3VEr5BGET0+r6lRJO+8ldTDIYeiB5G2jqaeHynAfmQy0vHGKsJ1qPJg22iMYNaaTchj2hlqA8
	/f5FhJxsfCXNSv/tX7zN74RnKKJrWazb3o1YVpBL9NI/mvVviRScL88FPqvj2gf6QQ8k9rTz50hcx
	OQEh/rbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8ad9-00000001ZZI-1My3;
	Mon, 21 Sep 2026 09:48:11 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8a6K-00000001TNC-2Gpo;
	Mon, 21 Sep 2026 09:14:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id EFE13601FB;
	Mon, 21 Sep 2026 09:14:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71221F00893;
	Mon, 21 Sep 2026 09:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789982055;
	bh=Ypk197u83QsJkKLOBorgGsgBYWL8I8pOcxYcooVQIRs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BVRV5Ip6eDfnma/w5Y/czw1VeMX630hiOe8uqSGXqsjooE2XeVRpukgHT2lEjnvWu
	 6fr7DPRbl1pT/tixy4qKPgbdfhGlYyRG8mVxxP2xFNh0JvBj5PDyfoXXUlBIFmZA4A
	 wfeqAXn7vlZ95v0+IozU1UxAIzm//WFXxIjRZk5wQ7PUdrDDUM00AjwNoSV4v7h67+
	 t6gcdL1zYAKxQ8SwXrjgniMvV5ehmJobw1qZvb6XreBmqT5M27b3dOBakHQLtTBGpL
	 7Qjs+OsKh7E9v3v5BGVIpCQ8aqce4Z1ksYxVuSAybhOUsiABwrrZkUDWyNB0hScgEj
	 Xg7AZ5lBqmQ9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/14] LoongArch: kexec_file: Fix elf_headers memory
 leak in retry loop
To: james.morse@arm.com, thuth@redhat.com, me@linux.beauty, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, vishal.l.verma@intel.com, pasha.tatashin@soleen.com, sourabhjain@linux.ibm.com, baoquan.he@linux.dev, chao.gao@intel.com, akpm@linux-foundation.org, kai.huang@intel.com, mingo@redhat.com, kernel@xen0n.name, seanjc@google.com, piliu@redhat.com, mclapinski@google.com, palmer@rivosinc.com, linuxppc-dev@lists.ozlabs.org, bp@alien8.de, mpe@ellerman.id.au, driver-core@lists.linux.dev, kees@kernel.org, gregkh@linuxfoundation.org, hbathini@linux.ibm.com, chleroy@kernel.org, leitao@debian.org, will@kernel.org, x86@kernel.org, dakr@kernel.org, guodongtai@kylinos.cn, hpa@zytor.com, maddy@linux.ibm.com, takahiro.akashi@linaro.org, catalin.marinas@arm.com, sshegde@linux.ibm.com, loongarch@lists.linux.dev, zhangtianyang@loongson.cn, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, maqianga@uniontech.com, mark.rutland@arm.com, chenhuacai@kernel.org, tangyouling@kylinos.cn, eric.devolder@oracle.com, tglx@kernel.org, ruirui.yang@linux.dev, graf@amazon.com, bgwin@google.com, npiggin@gmail.com, pratyush@kernel.org, rafael@kernel.org, yeoreum.yun@arm.com, coxu@redhat.com, liukexin@kylinos.cn, dave.hansen@linux.intel.com, ritesh.list@gmail.com, rppt@kernel.org, jbouron@amazon.com, robh@kernel.org
Cc: kexec@lists.infradead.org, ruanjinjie@huawei.com
In-Reply-To: <20260921090450.807575-8-ruanjinjie@huawei.com>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
 <20260921090450.807575-8-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 09:14:12 +0000
Message-Id: <20260921091412.C71221F00893@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921090450.8075=
75-1-ruanjinjie@huawei.com?part=3D7


