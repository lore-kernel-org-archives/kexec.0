Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA635C98302
	for <kexec@archiver.kernel.org>; Wed, 23 Sep 2026 06:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JNle6DdVpbG/BswqBxBR4WImK7gnKgjNKRAaR3X4LHs=; b=oGOD+ivq6jJ41zOlDvnhU2f+xQ
	KtKZdOUHNCuth8mx64VsXLAan/JgejACyR+5Iwd6xisfvQff3W9zAIaNqdNzaytldg26w1zyJ0TKt
	zPuuzwj6UpRBLslg5jdC6uNaoEnvPS7IKCVPM7trgszqW4ChsY/YxSZdHyWGZKbSHx/KcLpU9gnyD
	DnRw4+iIvCaqSVJ497G8/G6YDe94zbIGfqauXE4zrlkl2DrAuHgGHW0EaHpVybVEHWEQqs6dGnDjf
	3f49sugEpyyPjUJ5YM+fXPjKdm0j/C3D/LXkPPnQs2c8RiCTBWQ9gBC5TwXjxr17DAYvAjiz990v5
	0zqEkFyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9GHW-00000007Fxg-25qv;
	Wed, 23 Sep 2026 06:16:38 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9GHV-00000007FxL-1W53
	for kexec@lists.infradead.org;
	Wed, 23 Sep 2026 06:16:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8EF35600AA;
	Wed, 23 Sep 2026 06:16:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3AF1F000FF;
	Wed, 23 Sep 2026 06:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790144196;
	bh=JNle6DdVpbG/BswqBxBR4WImK7gnKgjNKRAaR3X4LHs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bkkWlJqNt/TkISo3l26HvKwQ1jDjP94mE2t9ahqoZjDLnN8nLUDcuzlFS0z3rFs4w
	 QJ0sUWd48WTlKN8i+ioSqilAeFcQkraeCxGLtUnQh12TA2Riz8KPdj4qC9vaDa1Aux
	 OSd47QMlu2zLmX7Syn0tpPHfJ2/Hpu0dPZPR9UznbM6BK1EwJG/sbMsbC5qoy7D3dl
	 mNeInmf6v9iLpdK/oYgpJ9if8TUI88Z3vi7tDwzB4n+p4YwgxvLblWUVTZXqSPfcwd
	 5Wn4pSMg0Hrv7rYun/A9hE4x/qdj44YvLS6PsqYKBqp5deWaZ7IG8QIUD+1mT2MOsX
	 3baRIEamqo1AA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] LoongArch: kdump: add arch_crash_save_vmcoreinfo()
 support
To: "Mike Rapoport" <rppt@kernel.org>, "Pratyush Yadav" <pratyush@kernel.org>, "Huacai
 Chen" <chenhuacai@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Yangyang
 Lian" <lianyangyang@kylinos.cn>, "Andrew Morton" <akpm@linux-foundation.org>, "Baoquan
 He" <baoquan.he@linux.dev>
Cc: "Haoran Jiang" <jianghaoran@kylinos.cn>, loongarch@lists.linux.dev, "WANG
 Xuerui" <kernel@xen0n.name>, "George Guo" <guodongtai@kylinos.cn>, "Dave
 Young" <ruirui.yang@linux.dev>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260923060349.146780-1-lianyangyang@kylinos.cn>
References: <20260923060349.146780-1-lianyangyang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 06:16:35 +0000
Message-Id: <20260923061635.8E3AF1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] kdump: off-by-one in VMEMMAP_END export causes incorrect range i=
n tools
--

commit 39488158a1b2af61bc47f6be1cf24b8ef1c6d7cd
Author: Yangyang Lian <lianyangyang@kylinos.cn>

LoongArch: kdump: add arch_crash_save_vmcoreinfo() support
   =20
This commit implements arch_crash_save_vmcoreinfo() for LoongArch to export
architecture-specific values to the vmcoreinfo PT_NOTE. This allows userspa=
ce
crash analysis tools to reliably derive module ranges, vmemmap ranges, VA_B=
ITS,
and the KASLR offset.

> diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentati=
on/admin-guide/kdump/vmcoreinfo.rst
> index 404a15f6782c3..a714ce4cf2141 100644
> --- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
> +++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst

[ ... ]

> +MODULES_VADDR|MODULES_END|VMALLOC_START|VMALLOC_END|VMEMMAP_START|VMEMMA=
P_END
> +------------------------------------------------------------------------=
-----
> +
> +Used to get the correct ranges:
> +	MODULES_VADDR ~ MODULES_END-1 : Kernel module space.
> +	VMALLOC_START ~ VMALLOC_END-1 : vmalloc() / ioremap() space.
> +	VMEMMAP_START ~ VMEMMAP_END-1 : vmemmap region, used for struct page ar=
ray.

[ ... ]

> diff --git a/arch/loongarch/kernel/vmcore_info.c b/arch/loongarch/kernel/=
vmcore_info.c
> new file mode 100644
> index 0000000000000..1128f6cdfe0dd
> --- /dev/null
> +++ b/arch/loongarch/kernel/vmcore_info.c

[ ... ]

> +void arch_crash_save_vmcoreinfo(void)
> +{
> +	VMCOREINFO_NUMBER(VA_BITS);
> +	/* NUMBER(VMALLOC_START) is exported by the generic code */
> +	vmcoreinfo_append_str("NUMBER(VMALLOC_END)=3D0x%lx\n", VMALLOC_END);
> +#ifdef CONFIG_64BIT
> +	vmcoreinfo_append_str("NUMBER(MODULES_VADDR)=3D0x%lx\n", MODULES_VADDR);
> +	vmcoreinfo_append_str("NUMBER(MODULES_END)=3D0x%lx\n", MODULES_END);
> +	vmcoreinfo_append_str("NUMBER(VMEMMAP_START)=3D0x%lx\n", (unsigned long=
)vmemmap);
> +	vmcoreinfo_append_str("NUMBER(VMEMMAP_END)=3D0x%lx\n", VMEMMAP_END);

[Severity: Medium]
Is this exporting the correct boundary for VMEMMAP_END?

As documented in the newly added admin-guide for vmcoreinfo (above), tools
like crash or makedumpfile expect the exported VMEMMAP_END to act as an
exclusive bound (VMEMMAP_START ~ VMEMMAP_END-1).

However, on LoongArch, the VMEMMAP_END macro is defined as an inclusive bou=
nd.
Exporting it directly without adjusting it to an exclusive bound
(e.g., VMEMMAP_END + 1) means the exported value is off by one byte.=20

Could this cause tools calculating the size via VMEMMAP_END - VMEMMAP_START
to get VMEMMAP_SIZE - 1, thereby truncating the last page when shifted and
triggering errors when analyzing the vmcore?

> +#endif
> +	vmcoreinfo_append_str("NUMBER(PHYS_OFFSET)=3D0x%lx\n", PHYS_OFFSET);
> +	vmcoreinfo_append_str("KERNELOFFSET=3D%lx\n", kaslr_offset());
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923060349.1467=
80-1-lianyangyang@kylinos.cn?part=3D1

