Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i0F2N-0002aM-KD
 for kexec@lists.infradead.org; Wed, 21 Aug 2019 01:03:45 +0000
References: <20190715082702.27308-1-svens@stackframe.org>
 <20190715082702.27308-2-svens@stackframe.org>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v4 1/7] kexec: add KEXEC_ELF
In-reply-to: <20190715082702.27308-2-svens@stackframe.org>
Date: Tue, 20 Aug 2019 21:58:35 -0300
Message-ID: <87zhk3mj0k.fsf@morokweng.localdomain>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org, deller@gmx.de, Sven Schnelle <svens@stackframe.org>


Hello Sven,

Just a few small comments below. Regardless of them:

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Sven Schnelle <svens@stackframe.org> writes:

> Right now powerpc provides an implementation to read elf files
> with the kexec_file() syscall. Make that available as a public

Nit: the syscall is kexec_file_load()

> kexec interface so it can be re-used on other architectures.
>
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>  arch/Kconfig                                  |   3 +
>  arch/powerpc/Kconfig                          |   1 +
>  arch/powerpc/kernel/kexec_elf_64.c            | 551 +-----------------
>  include/linux/kexec.h                         |  24 +
>  kernel/Makefile                               |   1 +
>  .../kexec_elf_64.c => kernel/kexec_elf.c      | 199 ++-----
>  6 files changed, 75 insertions(+), 704 deletions(-)
>  copy arch/powerpc/kernel/kexec_elf_64.c => kernel/kexec_elf.c (71%)

<snip>

> diff --git a/arch/powerpc/kernel/kexec_elf_64.c b/arch/powerpc/kernel/kexec_elf_64.c
> index ba4f18a43ee8..30bd57a93c17 100644
> --- a/arch/powerpc/kernel/kexec_elf_64.c
> +++ b/arch/powerpc/kernel/kexec_elf_64.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Load ELF vmlinux file for the kexec_file_load syscall.
>   *
> @@ -10,15 +11,6 @@
>   * Based on kexec-tools' kexec-elf-exec.c and kexec-elf-ppc64.c.
>   * Heavily modified for the kernel by
>   * Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation (version 2 of the License).
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
>   */
>
>  #define pr_fmt(fmt)	"kexec_elf: " fmt
> @@ -39,532 +31,6 @@
>  #define Elf_Rel		Elf64_Rel
>  #endif /* Elf_Rel */

Perhaps this patch could remove the #define for elf_addr_to_cpu since
it's not used anymore in this file?

> diff --git a/arch/powerpc/kernel/kexec_elf_64.c b/kernel/kexec_elf.c
> similarity index 71%
> copy from arch/powerpc/kernel/kexec_elf_64.c
> copy to kernel/kexec_elf.c
> index ba4f18a43ee8..6e9f52171ede 100644
> --- a/arch/powerpc/kernel/kexec_elf_64.c
> +++ b/kernel/kexec_elf.c
> @@ -1,33 +1,10 @@
> -/*
> - * Load ELF vmlinux file for the kexec_file_load syscall.
> - *
> - * Copyright (C) 2004  Adam Litke (agl@us.ibm.com)
> - * Copyright (C) 2004  IBM Corp.
> - * Copyright (C) 2005  R Sharada (sharada@in.ibm.com)
> - * Copyright (C) 2006  Mohan Kumar M (mohan@in.ibm.com)
> - * Copyright (C) 2016  IBM Corporation
> - *
> - * Based on kexec-tools' kexec-elf-exec.c and kexec-elf-ppc64.c.
> - * Heavily modified for the kernel by
> - * Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation (version 2 of the License).
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0-only

I may be wrong, but my understanding of the SPDX license identifier is
that it substitutes the license text (i.e., the last two paragraphs
above), but not the copyright statements. Is it ok to have a file with a
SPDX license identifier but no copyright statement?

--
Thiago Jung Bauermann
IBM Linux Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
