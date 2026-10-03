Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C898CA5FE3
	for <kexec@archiver.kernel.org>; Sat,  3 Oct 2026 09:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P7rAoJ5/n/5WLlrNeuWTZVKjqQomeDXh9uQGosF+PF8=; b=FegD3ABuhfBQ8wDWrqI+8H5Z7k
	DC8T864dRBvPcRnx/G3NKlInk9hH+YTNJ3l7rxNzKq8yidkrjVPgk15RwOVgChonaUlHg9aYTjmQT
	vhgLbt89jiKnaF0n2JxY0yAu0ku2B7+xy+bIWLqtghkw8OuaPknsPjDptaXKjs2ZKhaKzZVLDWe4P
	wUN3RtMw0aKLg1WqDgfDGQ6EEQxJE2bKn7/LhfT2SVx78RmnnHmwthKo3sCOTIQpHjBBN6+F+yUb4
	JKi0/qoAdemXR00JhVW05yY8k2eSqtyQJUg+b6vETItpPUBMnVVv8JvX8Y0vc98hKa1iISeEsyVnI
	zfXcL/TQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCvlL-0000000DExm-2VcI;
	Sat, 03 Oct 2026 09:10:35 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCvlK-0000000DExd-1o6R
	for kexec@lists.infradead.org;
	Sat, 03 Oct 2026 09:10:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D06BD4458C
	for <kexec@lists.infradead.org>; Sat,  3 Oct 2026 09:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B861F1F008A4
	for <kexec@lists.infradead.org>; Sat,  3 Oct 2026 09:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791018633;
	bh=P7rAoJ5/n/5WLlrNeuWTZVKjqQomeDXh9uQGosF+PF8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=mJn7R0YE7RRYZ5xM1pWVg2Ww0oaYZqSMVvwhzlNKriySlG+kPUjyAP9lQDosRc+SF
	 bb73Eew3ySBjCTIWzwVIifDg7ECtpvcsxnSYBt1+joao+6OdJvptjUg1nycT1LV7M8
	 thj1O6KHkRcvI7w4niiNn0MsTmCdrpAk0YbYnj3G8ZlizK5Rp102sS9Bow2o75jvbF
	 9/q00GvDkfT0WLvR/tj/55Tn7V+VOYUwceiETdoBENFLvRj+8zIrx2XnZ/popteEHk
	 +VDD1MVhDWFFURILLE33QqBEy4LFpVPoTZbtoF6oks3+xuA1CAm9rQ9+cJ57aDl1X3
	 fO6TB+LjtAAiA==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6ab006eb282so384043a12.0
        for <kexec@lists.infradead.org>; Sat, 03 Oct 2026 02:10:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzJkEzO2Ot5JGlmRJk/r6R1C85yXoQD1T6o8ucRktoR5DWtekW4rq6xJ4gne571+pHe6wdceQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYJeAR4k/gvFX1nn7Yrt0UyGIAe4CYerOwZEKFUNkGgL8l76wb2Q
	VnziqYBvmIBBlH35QxhZZ6LshKKJHfHUchyHNzS+yz/Snp0lFOBZlWO8qu6zpB8nryxZlZCdYbK
	0C++lyv4YBvGJO/9ZidWzRZX3Kp++0Bg=
X-Received: by 2002:a05:6402:20cf:b0:6ac:8761:17a1 with SMTP id
 4fb4d7f45d1cf-6afada2737fmr1406190a12.36.1791018632180; Sat, 03 Oct 2026
 02:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260923060349.146780-1-lianyangyang@kylinos.cn>
 <20260924075655.375632-1-lianyangyang@kylinos.cn> <CAAhV-H6C=AyS=1AejxxaG-Zri=2=AfMtPzXFxEvzpFdD1_AaAw@mail.gmail.com>
 <1b9d2426-fe5c-4227-976d-65ceb812c93c@tsinghua.org.cn>
In-Reply-To: <1b9d2426-fe5c-4227-976d-65ceb812c93c@tsinghua.org.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 3 Oct 2026 17:10:20 +0800
X-Gmail-Original-Message-ID: <CAAhV-H682iM2DydKK9+o7x93EapKRp=KQXnKQkoAK+yMeup44g@mail.gmail.com>
X-Gm-Features: AclHuK_L8q7-wOQE3LQDFkCVmAOEnizg-0482hbNFAZFXKix-vkoovdVlxzV_Es
Message-ID: <CAAhV-H682iM2DydKK9+o7x93EapKRp=KQXnKQkoAK+yMeup44g@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: kdump: add arch_crash_save_vmcoreinfo() support
To: Dave Young <yangrr.2009@tsinghua.org.cn>
Cc: Yangyang Lian <lianyangyang@kylinos.cn>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Dave Young <ruirui.yang@linux.dev>, WANG Xuerui <kernel@xen0n.name>, kexec@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Haoran Jiang <jianghaoran@kylinos.cn>, Tao Cui <cuitao@kylinos.cn>, 
	George Guo <guodongtai@kylinos.cn>
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

On Sat, Oct 3, 2026 at 4:25=E2=80=AFPM Dave Young <yangrr.2009@tsinghua.org=
.cn> wrote:
>
>
>
> On 9/28/26 10:28 PM, Huacai Chen wrote:
> > Hi, Yangyang,
> >
> > On Thu, Sep 24, 2026 at 3:58=E2=80=AFPM Yangyang Lian <lianyangyang@kyl=
inos.cn> wrote:
> >>
> >> Since commit 23c85094fe18 ("proc/kcore: add vmcoreinfo note to
> >> /proc/kcore") the kernel has exported the vmcoreinfo PT_NOTE on
> >> /proc/kcore as wellas /proc/vmcore.
> >>
> >> LoongArch does not provide arch_crash_save_vmcoreinfo(), so the
> >> arch-specific values are missing from the vmcoreinfo PT_NOTE. The
> >> generic exporter in kernel/vmcore_info.c already provides
> >> NUMBER(VMALLOC_START), but tools like crash cannot derive the module
> >> and vmemmap ranges, VA_BITS, or the KASLR offset of a LoongArch dump.
>
> current crash can get the kaslr offset from the _stext differ, so it just=
 works, but maybe makedumpfile still need the vmcoreinfo export.
>
> >>
> >> Since commit 18210a104bb9 ("LoongArch: Expand module virtual address
> >> space to 2GB") the vmalloc and module boundaries are no longer stable
> >> across kernel versions either, so vmcoreinfo is the only reliable
> >> source for them.
> >>
> >> Provide this function in a separate file that is built at the same tim=
e
> >> as its caller in kernel/vmcore_info.c, and add a LOONGARCH64 section t=
o
> >> Documentation/admin-guide/kdump/vmcoreinfo.rst.
> >>
> >> Reported-by: Haoran Jiang <jianghaoran@kylinos.cn>
> >> Suggested-by: Haoran Jiang <jianghaoran@kylinos.cn>
> >> Tested-by: Tao Cui <cuitao@kylinos.cn>
> >> Co-developed-by: George Guo <guodongtai@kylinos.cn>
> >> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> >> Signed-off-by: Yangyang Lian <lianyangyang@kylinos.cn>
> >> ---
> >> V2 -> V1: Export VMEMMAP_END + 1 to make it an exclusive bound, matchi=
ng
> >>           what tools like makedumpfile expect.
> >>           Add Tested-by tag from Tao Cui.
> >>
> >>  .../admin-guide/kdump/vmcoreinfo.rst          | 29 ++++++++++++++++++=
+
> >>  arch/loongarch/kernel/Makefile                |  1 +
> >>  arch/loongarch/kernel/vmcore_info.c           | 21 ++++++++++++++
> >>  3 files changed, 51 insertions(+)
> >>  create mode 100644 arch/loongarch/kernel/vmcore_info.c
> >>
> >> diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Document=
ation/admin-guide/kdump/vmcoreinfo.rst
> >> index 7663c610fe90..2ff921232616 100644
> >> --- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
> >> +++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> >> @@ -594,3 +594,32 @@ va_kernel_pa_offset
> >>
> >>  Indicates the offset between the kernel virtual and physical mappings=
.
> >>  Used to translate virtual to physical addresses.
> >> +
> >> +LOONGARCH64
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> +
> >> +VA_BITS
> >> +-------
> >> +
> >> +The maximum number of bits for virtual addresses. Used to compute the
> >> +virtual memory ranges.
> >> +
> >> +PHYS_OFFSET
> >> +-----------
> >> +
> >> +Indicates the physical address of the start of memory. Used to transl=
ate
> >> +virtual to physical addresses.
> >> +
> >> +KERNELOFFSET
> >> +------------
> >> +
> >> +The kernel randomization offset. Used to locate the kernel text in
> >> +virtual memory. If KASLR is disabled, this value is zero.
> >> +
> >> +MODULES_VADDR|MODULES_END|VMALLOC_START|VMALLOC_END|VMEMMAP_START|VME=
MMAP_END
> >> +---------------------------------------------------------------------=
--------
> >> +
> >> +Used to get the correct ranges:
> >> +       MODULES_VADDR ~ MODULES_END-1 : Kernel module space.
> >> +       VMALLOC_START ~ VMALLOC_END-1 : vmalloc() / ioremap() space.
> >> +       VMEMMAP_START ~ VMEMMAP_END-1 : vmemmap region, used for struc=
t page array.
> >> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Ma=
kefile
> >> index 001924877772..6260c15adaba 100644
> >> --- a/arch/loongarch/kernel/Makefile
> >> +++ b/arch/loongarch/kernel/Makefile
> >> @@ -64,6 +64,7 @@ obj-$(CONFIG_RELOCATABLE)     +=3D relocate.o
> >>  obj-$(CONFIG_KEXEC_CORE)       +=3D machine_kexec.o relocate_kernel.o
> >>  obj-$(CONFIG_KEXEC_FILE)       +=3D machine_kexec_file.o kexec_efi.o =
kexec_elf.o
> >>  obj-$(CONFIG_CRASH_DUMP)       +=3D crash_dump.o
> >> +obj-$(CONFIG_VMCORE_INFO)      +=3D vmcore_info.o
> >>
> >>  obj-$(CONFIG_UNWINDER_GUESS)   +=3D unwind_guess.o
> >>  obj-$(CONFIG_UNWINDER_PROLOGUE) +=3D unwind_prologue.o
> >> diff --git a/arch/loongarch/kernel/vmcore_info.c b/arch/loongarch/kern=
el/vmcore_info.c
> >> new file mode 100644
> >> index 000000000000..fb703b716253
> >> --- /dev/null
> >> +++ b/arch/loongarch/kernel/vmcore_info.c
> >> @@ -0,0 +1,21 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +
> >> +#include <linux/vmcore_info.h>
> >> +#include <asm/addrspace.h>
> >> +#include <asm/pgtable.h>
> >> +#include <asm/setup.h>
> >> +
> >> +void arch_crash_save_vmcoreinfo(void)
> >> +{
> >> +       VMCOREINFO_NUMBER(VA_BITS);
> >> +       /* NUMBER(VMALLOC_START) is exported by the generic code */
> >> +       vmcoreinfo_append_str("NUMBER(VMALLOC_END)=3D0x%lx\n", VMALLOC=
_END);
> >> +#ifdef CONFIG_64BIT
> >> +       vmcoreinfo_append_str("NUMBER(MODULES_VADDR)=3D0x%lx\n", MODUL=
ES_VADDR);
> >> +       vmcoreinfo_append_str("NUMBER(MODULES_END)=3D0x%lx\n", MODULES=
_END);
> >> +       vmcoreinfo_append_str("NUMBER(VMEMMAP_START)=3D0x%lx\n", (unsi=
gned long)vmemmap);
> >> +       vmcoreinfo_append_str("NUMBER(VMEMMAP_END)=3D0x%lx\n", VMEMMAP=
_END + 1);
> >> +#endif
> >> +       vmcoreinfo_append_str("NUMBER(PHYS_OFFSET)=3D0x%lx\n", PHYS_OF=
FSET);
> > I think it is also useful to export PAGE_OFFSET here.
>
> Hi Huacai,  if it is a fixed value or it can be derived from other known =
values I'd suggest not to export.
Hi, Dave. It is not completely a fixed value, and I found that RISC-V
also exports PAGE_OFFSET.

Huacai

>
> >
> > Huacai
> >> +       vmcoreinfo_append_str("KERNELOFFSET=3D%lx\n", kaslr_offset());
> >> +}
> >> --
> >> 2.25.1
> >>
> >>
> >
> >
> >
>
>

