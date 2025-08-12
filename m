Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE54CA0EDA
	for <kexec@archiver.kernel.org>; Tue, 12 Aug 2025 08:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XiGktqBxKpd0upMem0AJjQ0NQgQH9r396pmRFmlHwg0=; b=eySDvbcjr0wwwmmYW/z7bVscwL
	PyfBkoH8rjv/Pja1Q4Fbx0M8yWS80CI/Eeq2c7sBnOa5++T/ICqqBlSjGLrZreWjpPFuGFSAzdR71
	oiiGsElwRLfX9bjY4fyBlqq7f+AO5pMmickAkroBERSkl6YvyugCUSD6X3lqJPePSg7ku6pJXzZAo
	5ZK5Ky9OKpLvSdae5vZeWvtGzMdy1HcG4RZwHQKWsPCf4AkD9Z+n9lCbIqVjQm0U+JjE2AD67ljLs
	D5WgBLrZy9MDhCklR9AL2a5SjM/Bzx4lXByNaA9sRMJV9cWLEb0xZBdw2PSQLGiASWD7Jv5sDRZU5
	GzC82APA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uljyR-0000000AByr-1MJk;
	Tue, 12 Aug 2025 08:03:11 +0000
Received: from layka.disroot.org ([178.21.23.139])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uljs9-0000000AAeI-366W
	for kexec@lists.infradead.org;
	Tue, 12 Aug 2025 07:56:43 +0000
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 4415E20F50;
	Tue, 12 Aug 2025 09:56:37 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id glnkyHfjUfM9; Tue, 12 Aug 2025 09:56:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1754985396; bh=lqChg/BwKR8Q8MrSc+NExDtpkBdUqJRQkLtzpoeak8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OxVOkeMnfMnAz4V4Fg6cLd0ZkuTUNF0QaZcl1twXUY2nFYSk5JCXszY3FAs8l1ZwJ
	 NSzXjgxcgyOTk0rDdgy6HPyHmUqZUVXaHwIWgulMhGahWTJXh5UMSm5WM0kjyvQY7U
	 NjZklvb0VWdH29VREneUm15I73Mh/+YIRMYKdXdRbCE+x9E1yCGacFn4mNiOFAXArb
	 nCOAivxAFipg2pDgzMxqKNRQwh7ScG2/Fxni8EqMQyRjwuz6lwfc19JnC+lpwjH4e1
	 z41MsxFrf9z27VyopFJs85P/432+BFkobOJ/BIChZEa6eunWkh17aTKuRxYgu8bJWw
	 1HcD8oiLDAdvg==
Date: Tue, 12 Aug 2025 07:56:22 +0000
From: Yao Zi <ziyao@disroot.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Youling Tang <youling.tang@linux.dev>, WANG Xuerui <kernel@xen0n.name>,
	Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
	Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH 2/6] LoongArch: Add kexec_file support
Message-ID: <aJrzpiSbs5Gt6Lel@pie>
References: <20250811092659.14903-1-youling.tang@linux.dev>
 <20250811092659.14903-3-youling.tang@linux.dev>
 <aJojDiHWi8cgvA2W@pie>
 <CAAhV-H4wz2Kw=PUOVeaqCHVZV3YwWPACg1GK5J3yph6SHTwOBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H4wz2Kw=PUOVeaqCHVZV3YwWPACg1GK5J3yph6SHTwOBw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_005642_327898_53CA14FE 
X-CRM114-Status: GOOD (  39.22  )
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

On Tue, Aug 12, 2025 at 10:39:59AM +0800, Huacai Chen wrote:
> On Tue, Aug 12, 2025 at 1:09 AM Yao Zi <ziyao@disroot.org> wrote:
> >
> > On Mon, Aug 11, 2025 at 05:26:55PM +0800, Youling Tang wrote:
> > > From: Youling Tang <tangyouling@kylinos.cn>
> > >
> > > This patch adds support for kexec_file on LoongArch.
> > >
> > > The image_load() as two parts:
> > > - the first part loads the kernel image (vmlinuz.efi or vmlinux.efi)
> > > - the second part loads other segments (eg: initrd, cmdline)
> > >
> > > Currently, pez(vmlinuz.efi) and pei(vmlinux.efi) format images are supported,
> > > but ELF format is not supported.
> > >
> > > Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> > > ---
> > >  arch/loongarch/Kconfig                     |   8 ++
> > >  arch/loongarch/include/asm/image.h         |  18 ++++
> > >  arch/loongarch/include/asm/kexec.h         |  12 +++
> > >  arch/loongarch/kernel/Makefile             |   1 +
> > >  arch/loongarch/kernel/kexec_image.c        | 112 +++++++++++++++++++++
> > >  arch/loongarch/kernel/machine_kexec.c      |  33 ++++--
> > >  arch/loongarch/kernel/machine_kexec_file.c |  46 +++++++++
> > >  7 files changed, 219 insertions(+), 11 deletions(-)
> > >  create mode 100644 arch/loongarch/kernel/kexec_image.c
> > >  create mode 100644 arch/loongarch/kernel/machine_kexec_file.c
> >
> > > diff --git a/arch/loongarch/kernel/kexec_image.c b/arch/loongarch/kernel/kexec_image.c
> > > new file mode 100644
> > > index 000000000000..fdd1845b4e2e
> > > --- /dev/null
> > > +++ b/arch/loongarch/kernel/kexec_image.c
> > > @@ -0,0 +1,112 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Kexec image loader for LoongArch
> > > +
> > > + * Author: Youling Tang <tangyouling@kylinos.cn>
> > > + * Copyright (C) 2025 KylinSoft Corporation.
> > > + */
> > > +
> > > +#define pr_fmt(fmt)  "kexec_file(Image): " fmt
> > > +
> > > +#include <linux/err.h>
> > > +#include <linux/errno.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/kexec.h>
> > > +#include <linux/pe.h>
> > > +#include <linux/string.h>
> > > +#include <asm/byteorder.h>
> > > +#include <asm/cpufeature.h>
> > > +#include <asm/image.h>
> > > +
> > > +static int image_probe(const char *kernel_buf, unsigned long kernel_len)
> > > +{
> > > +     const struct loongarch_image_header *h =
> > > +             (const struct loongarch_image_header *)(kernel_buf);
> >
> > Parentheses around "kernel_buf" are unnecessary.
> >
> > > +     if (!h || (kernel_len < sizeof(*h))) {
> >
> > Comparisons have higher priority than logic operations, so this pair of
> > parentheses is redundant, too.
> But the kernel coding style suggest to use parentheses in this case.

Could you please quote the original text? I have read through
Documentation/process/coding-style.rst again but didn't find similar
suggestions...

And git grep '[[:alnum:]]\+ || [[:alnum:]_]\+ [<>]=\?' results in more
than 7000 matches, including 25 in arch/loongarch...

Anyway, this is a little nitpick. I'm just pointing out the expression
is equal to "!h || kernel_len < sizeof(*h)", and whether it's simplified
is fine to me.

> >
> > > +             pr_err("No loongarch image header.\n");
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     if (!loongarch_header_check_pe_sig(h)) {
> > > +             pr_err("Bad loongarch PE image header.\n");
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     return 0;
> > > +}

...

> > > diff --git a/arch/loongarch/kernel/machine_kexec.c b/arch/loongarch/kernel/machine_kexec.c
> > > index f9381800e291..008f43e26120 100644
> > > --- a/arch/loongarch/kernel/machine_kexec.c
> > > +++ b/arch/loongarch/kernel/machine_kexec.c
> > > @@ -70,18 +70,28 @@ int machine_kexec_prepare(struct kimage *kimage)
> >
> > ...
> >
> > > -     if (!kimage->arch.cmdline_ptr) {
> > > -             pr_err("Command line not included in the provided image\n");
> > > -             return -EINVAL;
> > > +             if (!kimage->arch.cmdline_ptr) {
> > > +                     pr_err("Command line not included in the provided image\n");
> > > +                     return -EINVAL;
> > > +             }
> > >       }
> > >
> > >       /* kexec/kdump need a safe page to save reboot_code_buffer */
> > > @@ -288,7 +298,8 @@ void machine_kexec(struct kimage *image)
> > >       local_irq_disable();
> > >
> > >       pr_notice("EFI boot flag 0x%lx\n", efi_boot);
> > > -     pr_notice("Command line at 0x%lx\n", cmdline_ptr);
> > > +     pr_notice("Command line addr at 0x%lx\n", cmdline_ptr);
> > > +     pr_notice("Command line at %s\n", (char *)cmdline_ptr);
> >
> > The printed message doesn't match meaning of the pointer: you're
> > printing the content of cmdline_ptr, instead of its address, thus
> > "Command line at" sounds confusing to me.
> >
> > Furthermore, this chunk isn't related to "support for kexec_file", I
> > think it's better to separate it into another patch (or even another
> > series).
> Separating is not necessary from my point of view, indeed I suggest to
> squash patches in this series.

I realized this comment is a little nitpicking, too, so I'm going to say
either is fine to me.

> Huacai

Best regards,
Yao Zi

> >
> > >       pr_notice("System table at 0x%lx\n", systable_ptr);
> > >       pr_notice("We will call new kernel at 0x%lx\n", start_addr);
> > >       pr_notice("Bye ...\n");
> >
> > Best regards,
> > Yao Zi
> 

