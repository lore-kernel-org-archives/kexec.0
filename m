Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96799CA5FA5
	for <kexec@archiver.kernel.org>; Mon, 28 Sep 2026 14:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YPzStzDokfiX/VDV5QtJf5+kUVF9DbxDMP+IisfKyT8=; b=XFUNaSpdj3u3jn3texkaT/eD6e
	Qd0Ymgu8y/Icx+iKVrJCAIEUYmMgzRvbpn4FIX4x6UIJiepZFliSzKv30gy3rHZHbD6s138gDMHHy
	7+rl2JoE0VrIthbeFgUN1eVKmCbBgpeBLVeDcaeaWLUKtewCZHBkOz++LZcyWto1W43ooWkZOfWAJ
	hfXchn+SPDRWtRyN+oIxkNc2CqiW9UUGaWnrwA1KZxrTZtn7NNVI1se8vatQ7jff9BpB1rPDLFHyb
	UCTsVPmhbiYF32wE/0FX1OCLmwo2vCz87OfOLss0z0KiPgkpsxzG7yJrqpQb92mWmr83AxdHieETc
	Gwzo4rEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBCLN-00000000l74-3nkM;
	Mon, 28 Sep 2026 14:28:37 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBCLM-00000000l6y-1Ztu
	for kexec@lists.infradead.org;
	Mon, 28 Sep 2026 14:28:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7AA11600D1
	for <kexec@lists.infradead.org>; Mon, 28 Sep 2026 14:28:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330B31F00899
	for <kexec@lists.infradead.org>; Mon, 28 Sep 2026 14:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790605715;
	bh=YPzStzDokfiX/VDV5QtJf5+kUVF9DbxDMP+IisfKyT8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YSfs5RMkDkKbpdzc32rdg+UCY/r9+hJ4gXPA0BaxZjWobloLH0meA7L2Ndcg0MVMQ
	 voaDBj0dh4OTL3lIsFGVGWx7do1U1dPHpnaUxjioi49KxFmH9IopR+IJI8U6Ii8YDh
	 52dleR4BVfIhNROssUvwdUsnLXo8FPOsTuIhnGKdhBJu918fDO88XDdjlxZQLIN2Tj
	 SRRLN2HiCbJzv2aauias77hq4rOI86GltxBrmlKWMhETrsZQpGXC8Sgn1+6iwZ8awn
	 UOIG2a6m+KM3jzZEUwIQ5ifhB00RG15phzB/filJQ+cs8ad8Tz19galLNSZqlbqFOm
	 qpDinbQwKJhUg==
Received: by mail-ed2-f33.google.com with SMTP id 4fb4d7f45d1cf-6abe19c4262so2154407a12.3
        for <kexec@lists.infradead.org>; Mon, 28 Sep 2026 07:28:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwM3YjNcu2MSQN9fLVCksu/i/oCEZjkSYcGiUxsZ4EYpngDXODReMtzGvEA7DTkIeShJUwE+Q==@lists.infradead.org
X-Gm-Message-State: AFq9FYKhQs+0ma4k85LJesXN2JzEmj6myd0hrViXk1U6CC6EaHov85ff
	m8+7q6ppeHGiAbos8TuB1NjABW5I5r0w5zkqpMDWwhxRp0asWZuX4G8Bt2b8OVpt+E1VL9XjGvI
	tSjxPn/SPD84noA+h95sVcks/O8xT09c=
X-Received: by 2002:a05:6402:4011:b0:6ac:62aa:e3dc with SMTP id
 4fb4d7f45d1cf-6ac62aaea73mr3602685a12.26.1790605713775; Mon, 28 Sep 2026
 07:28:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260923060349.146780-1-lianyangyang@kylinos.cn> <20260924075655.375632-1-lianyangyang@kylinos.cn>
In-Reply-To: <20260924075655.375632-1-lianyangyang@kylinos.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 28 Sep 2026 22:28:23 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6C=AyS=1AejxxaG-Zri=2=AfMtPzXFxEvzpFdD1_AaAw@mail.gmail.com>
X-Gm-Features: AclHuK_Cw3Fa7E90RJ5ekvaNPqdQ2_xMfC9MdHhXGybH75CyqmNPIL39bdqS-mU
Message-ID: <CAAhV-H6C=AyS=1AejxxaG-Zri=2=AfMtPzXFxEvzpFdD1_AaAw@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: kdump: add arch_crash_save_vmcoreinfo() support
To: Yangyang Lian <lianyangyang@kylinos.cn>
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <baoquan.he@linux.dev>, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Dave Young <ruirui.yang@linux.dev>, 
	WANG Xuerui <kernel@xen0n.name>, kexec@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Haoran Jiang <jianghaoran@kylinos.cn>, 
	Tao Cui <cuitao@kylinos.cn>, George Guo <guodongtai@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi, Yangyang,

On Thu, Sep 24, 2026 at 3:58=E2=80=AFPM Yangyang Lian <lianyangyang@kylinos=
.cn> wrote:
>
> Since commit 23c85094fe18 ("proc/kcore: add vmcoreinfo note to
> /proc/kcore") the kernel has exported the vmcoreinfo PT_NOTE on
> /proc/kcore as wellas /proc/vmcore.
>
> LoongArch does not provide arch_crash_save_vmcoreinfo(), so the
> arch-specific values are missing from the vmcoreinfo PT_NOTE. The
> generic exporter in kernel/vmcore_info.c already provides
> NUMBER(VMALLOC_START), but tools like crash cannot derive the module
> and vmemmap ranges, VA_BITS, or the KASLR offset of a LoongArch dump.
>
> Since commit 18210a104bb9 ("LoongArch: Expand module virtual address
> space to 2GB") the vmalloc and module boundaries are no longer stable
> across kernel versions either, so vmcoreinfo is the only reliable
> source for them.
>
> Provide this function in a separate file that is built at the same time
> as its caller in kernel/vmcore_info.c, and add a LOONGARCH64 section to
> Documentation/admin-guide/kdump/vmcoreinfo.rst.
>
> Reported-by: Haoran Jiang <jianghaoran@kylinos.cn>
> Suggested-by: Haoran Jiang <jianghaoran@kylinos.cn>
> Tested-by: Tao Cui <cuitao@kylinos.cn>
> Co-developed-by: George Guo <guodongtai@kylinos.cn>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> Signed-off-by: Yangyang Lian <lianyangyang@kylinos.cn>
> ---
> V2 -> V1: Export VMEMMAP_END + 1 to make it an exclusive bound, matching
>           what tools like makedumpfile expect.
>           Add Tested-by tag from Tao Cui.
>
>  .../admin-guide/kdump/vmcoreinfo.rst          | 29 +++++++++++++++++++
>  arch/loongarch/kernel/Makefile                |  1 +
>  arch/loongarch/kernel/vmcore_info.c           | 21 ++++++++++++++
>  3 files changed, 51 insertions(+)
>  create mode 100644 arch/loongarch/kernel/vmcore_info.c
>
> diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentati=
on/admin-guide/kdump/vmcoreinfo.rst
> index 7663c610fe90..2ff921232616 100644
> --- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
> +++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> @@ -594,3 +594,32 @@ va_kernel_pa_offset
>
>  Indicates the offset between the kernel virtual and physical mappings.
>  Used to translate virtual to physical addresses.
> +
> +LOONGARCH64
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +VA_BITS
> +-------
> +
> +The maximum number of bits for virtual addresses. Used to compute the
> +virtual memory ranges.
> +
> +PHYS_OFFSET
> +-----------
> +
> +Indicates the physical address of the start of memory. Used to translate
> +virtual to physical addresses.
> +
> +KERNELOFFSET
> +------------
> +
> +The kernel randomization offset. Used to locate the kernel text in
> +virtual memory. If KASLR is disabled, this value is zero.
> +
> +MODULES_VADDR|MODULES_END|VMALLOC_START|VMALLOC_END|VMEMMAP_START|VMEMMA=
P_END
> +------------------------------------------------------------------------=
-----
> +
> +Used to get the correct ranges:
> +       MODULES_VADDR ~ MODULES_END-1 : Kernel module space.
> +       VMALLOC_START ~ VMALLOC_END-1 : vmalloc() / ioremap() space.
> +       VMEMMAP_START ~ VMEMMAP_END-1 : vmemmap region, used for struct p=
age array.
> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makef=
ile
> index 001924877772..6260c15adaba 100644
> --- a/arch/loongarch/kernel/Makefile
> +++ b/arch/loongarch/kernel/Makefile
> @@ -64,6 +64,7 @@ obj-$(CONFIG_RELOCATABLE)     +=3D relocate.o
>  obj-$(CONFIG_KEXEC_CORE)       +=3D machine_kexec.o relocate_kernel.o
>  obj-$(CONFIG_KEXEC_FILE)       +=3D machine_kexec_file.o kexec_efi.o kex=
ec_elf.o
>  obj-$(CONFIG_CRASH_DUMP)       +=3D crash_dump.o
> +obj-$(CONFIG_VMCORE_INFO)      +=3D vmcore_info.o
>
>  obj-$(CONFIG_UNWINDER_GUESS)   +=3D unwind_guess.o
>  obj-$(CONFIG_UNWINDER_PROLOGUE) +=3D unwind_prologue.o
> diff --git a/arch/loongarch/kernel/vmcore_info.c b/arch/loongarch/kernel/=
vmcore_info.c
> new file mode 100644
> index 000000000000..fb703b716253
> --- /dev/null
> +++ b/arch/loongarch/kernel/vmcore_info.c
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/vmcore_info.h>
> +#include <asm/addrspace.h>
> +#include <asm/pgtable.h>
> +#include <asm/setup.h>
> +
> +void arch_crash_save_vmcoreinfo(void)
> +{
> +       VMCOREINFO_NUMBER(VA_BITS);
> +       /* NUMBER(VMALLOC_START) is exported by the generic code */
> +       vmcoreinfo_append_str("NUMBER(VMALLOC_END)=3D0x%lx\n", VMALLOC_EN=
D);
> +#ifdef CONFIG_64BIT
> +       vmcoreinfo_append_str("NUMBER(MODULES_VADDR)=3D0x%lx\n", MODULES_=
VADDR);
> +       vmcoreinfo_append_str("NUMBER(MODULES_END)=3D0x%lx\n", MODULES_EN=
D);
> +       vmcoreinfo_append_str("NUMBER(VMEMMAP_START)=3D0x%lx\n", (unsigne=
d long)vmemmap);
> +       vmcoreinfo_append_str("NUMBER(VMEMMAP_END)=3D0x%lx\n", VMEMMAP_EN=
D + 1);
> +#endif
> +       vmcoreinfo_append_str("NUMBER(PHYS_OFFSET)=3D0x%lx\n", PHYS_OFFSE=
T);
I think it is also useful to export PAGE_OFFSET here.

Huacai
> +       vmcoreinfo_append_str("KERNELOFFSET=3D%lx\n", kaslr_offset());
> +}
> --
> 2.25.1
>
>

