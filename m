Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C3A2CA0FE8
	for <kexec@archiver.kernel.org>; Fri, 22 Aug 2025 11:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UHaOYEskbK2eogEjs+jz01wOMa+9+8gvw5EM7E8vtkc=; b=mlqMn6VVwTBOS3OQak2MYmnvRV
	mNZDeDOPVZ74Kj8A+/MGvyxF2LSWRjbblMW5/c5/jQS0c4VRUp0aJsLbaGK/gqMH9Au1axL9u43NV
	XkKx1v0zQuSFzxTJd5ZOVPIq7oZQBtM1HvV3DmSGWrjyKgRbMqxLh4ilMWzV558UfHUtdVrGN2WTo
	kISiipUh6rSXY9X4287hejmxOWe+YldJtbfHznn434KUsfw7Vr4zV7x0N8Fy6xcChGPSE9eQGDMsv
	77FUWCfSz6G/yW0VSa/E9mSvBTuIUIYn2/KOoBA14VYulJymv7q5YPYuVZlUHSkME2683bpbH+XqB
	1z58emWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upQGI-00000002NTz-2b0N;
	Fri, 22 Aug 2025 11:48:50 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upLSY-00000001iUY-0wgX
	for kexec@lists.infradead.org;
	Fri, 22 Aug 2025 06:41:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id EBFC144073
	for <kexec@lists.infradead.org>; Fri, 22 Aug 2025 06:41:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B425AC113D0
	for <kexec@lists.infradead.org>; Fri, 22 Aug 2025 06:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755844869;
	bh=zpYv+55z9hfkhhRESoRgSo3d++ULzMHj9eLxjAkGBYM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HSiclG5DgNwMjDidyLtSamzrRzu7cI532AM208xGx+DEabyf7EZps2ujJJBU1/5Rc
	 5Tg5+bMo/iDYmTVufs10VE1mmf3Nj1/jYS6lNZxQsLIlmIkx6Bp3uW+yPP1oBIVX8B
	 oORIyeD0OXNRg5/02/95AAbFH8UY3vCPEDtBivShwAfnJe5UqhsShEje5VglSxe72e
	 MuEfi5P31OG6xesDNy2JxoFv5t7fyaj1XCWN4n3hFocxx0ekkCmFm9iA7l3ryR+Ntu
	 eux9lSm8rGaO3ckTtm9mQd+pVxp4QErBiDGyOBQvFELZxPHvwkPUQX0P89Er3ivUZ2
	 F1GxWSH/CbQpA==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6188b7550c0so2580995a12.2
        for <kexec@lists.infradead.org>; Thu, 21 Aug 2025 23:41:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUizVkJinoxYxouWV9m9uy4gQbtQ8FeED8TT6q9J6X+BW9H8k90FTrwdQJXLbi452jUhLWcTA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwDIgRR/fxuGuUfrbrjmxvuuaUj90pVYwlBSAxFSAqJr8CMaLvZ
	y1aQGxKHFxIstRDlILHwVUj+aRK+PVjFoRgTTAoX6zSGHUS17JPWDcyZq33BRVV/ikdF/6FDfuN
	TaZN36La7Krly8S672kf5ngU+vu8MPoE=
X-Google-Smtp-Source: AGHT+IFKFtbxptrH35g2h2gONe2NPkyM6nkxZhgAotlR1Tv9/gEF9b7cQt7+ob0mJJ+R+F9PckHcYY/AqdkOswvDtoM=
X-Received: by 2002:a05:6402:26c6:b0:615:5cc1:3453 with SMTP id
 4fb4d7f45d1cf-61c1b3d8cdbmr1502515a12.9.1755844868066; Thu, 21 Aug 2025
 23:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250820055700.24344-1-youling.tang@linux.dev> <20250820055700.24344-3-youling.tang@linux.dev>
In-Reply-To: <20250820055700.24344-3-youling.tang@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 22 Aug 2025 14:40:55 +0800
X-Gmail-Original-Message-ID: <CAAhV-H644+w+j+p6S-3aS_q9WryaArVpoYTae1s_ad6Voke3tw@mail.gmail.com>
X-Gm-Features: Ac12FXz9qh94X2P8lVHI0F3ea7UwysGPUP2VBRZ2AjzPabMMShWc1Fxq2ZAzbK8
Message-ID: <CAAhV-H644+w+j+p6S-3aS_q9WryaArVpoYTae1s_ad6Voke3tw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] LoongArch: Add kexec_file support
To: Youling Tang <youling.tang@linux.dev>
Cc: WANG Xuerui <kernel@xen0n.name>, Baoquan He <bhe@redhat.com>, Yao Zi <ziyao@disroot.org>, 
	kexec@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250821_234110_310992_F2E3432D 
X-CRM114-Status: GOOD (  41.61  )
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

Hi, Youling,

On Wed, Aug 20, 2025 at 1:57=E2=80=AFPM Youling Tang <youling.tang@linux.de=
v> wrote:
>
> From: Youling Tang <tangyouling@kylinos.cn>
>
> This patch adds support for kexec_file on LoongArch.
>
> The efi_kexec_load() as two parts:
> - the first part loads the kernel image (vmlinuz.efi or vmlinux.efi)
> - the second part loads other segments (eg: initrd, cmdline)
>
> This initrd will be passed to the second kernel via the command line
> 'initrd=3Dstart,size'.
>
> Currently, pez(vmlinuz.efi) and pei(vmlinux.efi) format images are suppor=
ted,
> but ELF format is not supported.
>
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> ---
>  arch/loongarch/Kconfig                     |   9 ++
>  arch/loongarch/include/asm/image.h         |  17 +++
>  arch/loongarch/include/asm/kexec.h         |  12 +++
>  arch/loongarch/kernel/Makefile             |   1 +
>  arch/loongarch/kernel/kexec_efi.c          | 111 +++++++++++++++++++
>  arch/loongarch/kernel/machine_kexec.c      |  33 ++++--
>  arch/loongarch/kernel/machine_kexec_file.c | 117 +++++++++++++++++++++
>  7 files changed, 289 insertions(+), 11 deletions(-)
>  create mode 100644 arch/loongarch/kernel/kexec_efi.c
>  create mode 100644 arch/loongarch/kernel/machine_kexec_file.c
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index f0abc38c40ac..490dc6eed749 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -625,6 +625,15 @@ config CPU_HAS_PREFETCH
>  config ARCH_SUPPORTS_KEXEC
>         def_bool y
>
> +config ARCH_SUPPORTS_KEXEC_FILE
> +       def_bool 64BIT
> +
> +config ARCH_SELECTS_KEXEC_FILE
> +       def_bool y
> +       depends on KEXEC_FILE
> +       select HAVE_IMA_KEXEC if IMA
> +       select RELOCATABLE
> +
>  config ARCH_SUPPORTS_CRASH_DUMP
>         def_bool y
>
> diff --git a/arch/loongarch/include/asm/image.h b/arch/loongarch/include/=
asm/image.h
> index 1f090736e71d..655d5836c4e8 100644
> --- a/arch/loongarch/include/asm/image.h
> +++ b/arch/loongarch/include/asm/image.h
> @@ -36,5 +36,22 @@ struct loongarch_image_header {
>         uint32_t pe_header;
>  };
>
> +static const uint8_t loongarch_image_pe_sig[2] =3D {'M', 'Z'};
> +
> +/**
> + * loongarch_header_check_pe_sig - Helper to check the loongarch image h=
eader.
> + *
> + * Returns non-zero if 'MZ' signature is found.
> + */
> +
> +static inline int loongarch_header_check_pe_sig(const struct loongarch_i=
mage_header *h)
> +{
> +       if (!h)
> +               return 0;
> +
> +       return (h->pe_sig[0] =3D=3D loongarch_image_pe_sig[0]
> +               && h->pe_sig[1] =3D=3D loongarch_image_pe_sig[1]);
> +}
> +
>  #endif /* __ASSEMBLY__ */
>  #endif /* __ASM_IMAGE_H */
> diff --git a/arch/loongarch/include/asm/kexec.h b/arch/loongarch/include/=
asm/kexec.h
> index cf95cd3eb2de..34799db933fb 100644
> --- a/arch/loongarch/include/asm/kexec.h
> +++ b/arch/loongarch/include/asm/kexec.h
> @@ -41,6 +41,18 @@ struct kimage_arch {
>         unsigned long systable_ptr;
>  };
>
> +#ifdef CONFIG_KEXEC_FILE
> +extern const struct kexec_file_ops kexec_efi_ops;
> +
> +int arch_kimage_file_post_load_cleanup(struct kimage *image);
> +#define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cl=
eanup
> +
> +extern int load_other_segments(struct kimage *image,
> +               unsigned long kernel_load_addr, unsigned long kernel_size=
,
> +               char *initrd, unsigned long initrd_len,
> +               char *cmdline, unsigned long cmdline_len);
> +#endif
> +
>  typedef void (*do_kexec_t)(unsigned long efi_boot,
>                            unsigned long cmdline_ptr,
>                            unsigned long systable_ptr,
> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makef=
ile
> index 6f5a4574a911..dd6183f353e6 100644
> --- a/arch/loongarch/kernel/Makefile
> +++ b/arch/loongarch/kernel/Makefile
> @@ -62,6 +62,7 @@ obj-$(CONFIG_MAGIC_SYSRQ)     +=3D sysrq.o
>  obj-$(CONFIG_RELOCATABLE)      +=3D relocate.o
>
>  obj-$(CONFIG_KEXEC_CORE)       +=3D machine_kexec.o relocate_kernel.o
> +obj-$(CONFIG_KEXEC_FILE)       +=3D machine_kexec_file.o kexec_efi.o
>  obj-$(CONFIG_CRASH_DUMP)       +=3D crash_dump.o
>
>  obj-$(CONFIG_UNWINDER_GUESS)   +=3D unwind_guess.o
> diff --git a/arch/loongarch/kernel/kexec_efi.c b/arch/loongarch/kernel/ke=
xec_efi.c
> new file mode 100644
> index 000000000000..7741f1139a12
> --- /dev/null
> +++ b/arch/loongarch/kernel/kexec_efi.c
> @@ -0,0 +1,111 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Load EFI vmlinux file for the kexec_file_load syscall.
> + *
> + * Author: Youling Tang <tangyouling@kylinos.cn>
> + * Copyright (C) 2025 KylinSoft Corporation.
> + */
> +
> +#define pr_fmt(fmt)    "kexec_file(EFI): " fmt
> +
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/kexec.h>
> +#include <linux/pe.h>
> +#include <linux/string.h>
> +#include <asm/byteorder.h>
> +#include <asm/cpufeature.h>
> +#include <asm/image.h>
> +
> +static int efi_kexec_probe(const char *kernel_buf, unsigned long kernel_=
len)
> +{
> +       const struct loongarch_image_header *h =3D (const struct loongarc=
h_image_header *)kernel_buf;
> +
> +       if (!h || (kernel_len < sizeof(*h))) {
> +               pr_err("No loongarch image header.\n");
> +               return -EINVAL;
> +       }
> +
> +       if (!loongarch_header_check_pe_sig(h)) {
> +               pr_warn("No loongarch PE image header.\n");
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static void *efi_kexec_load(struct kimage *image,
> +                               char *kernel, unsigned long kernel_len,
> +                               char *initrd, unsigned long initrd_len,
> +                               char *cmdline, unsigned long cmdline_len)
> +{
> +       struct loongarch_image_header *h;
> +       struct kexec_buf kbuf;
> +       unsigned long text_offset, kernel_segment_number;
> +       struct kexec_segment *kernel_segment;
> +       int ret;
> +
> +       h =3D (struct loongarch_image_header *)kernel;
> +       if (!h->image_size)
> +               return ERR_PTR(-EINVAL);
> +
> +       /* Load the kernel */
> +       kbuf.image =3D image;
> +       kbuf.buf_max =3D ULONG_MAX;
> +       kbuf.top_down =3D false;
> +
> +       kbuf.buffer =3D kernel;
> +       kbuf.bufsz =3D kernel_len;
> +       kbuf.mem =3D KEXEC_BUF_MEM_UNKNOWN;
> +       kbuf.memsz =3D le64_to_cpu(h->image_size);
> +       text_offset =3D le64_to_cpu(h->text_offset);
> +       kbuf.buf_min =3D text_offset;
> +       kbuf.buf_align =3D SZ_2M;
> +
> +       kernel_segment_number =3D image->nr_segments;
> +
> +       /*
> +        * The location of the kernel segment may make it impossible to s=
atisfy
> +        * the other segment requirements, so we try repeatedly to find a
> +        * location that will work.
> +        */
> +       while ((ret =3D kexec_add_buffer(&kbuf)) =3D=3D 0) {
> +               /* Try to load additional data */
> +               kernel_segment =3D &image->segment[kernel_segment_number]=
;
> +               ret =3D load_other_segments(image, kernel_segment->mem,
> +                                         kernel_segment->memsz, initrd,
> +                                         initrd_len, cmdline, cmdline_le=
n);
> +               if (!ret)
> +                       break;
> +
> +               /*
> +                * We couldn't find space for the other segments; erase t=
he
> +                * kernel segment and try the next available hole.
> +                */
> +               image->nr_segments -=3D 1;
> +               kbuf.buf_min =3D kernel_segment->mem + kernel_segment->me=
msz;
> +               kbuf.mem =3D KEXEC_BUF_MEM_UNKNOWN;
> +       }
> +
> +       if (ret) {
> +               pr_err("Could not find any suitable kernel location!");
> +               return ERR_PTR(ret);
> +       }
> +
> +       kernel_segment =3D &image->segment[kernel_segment_number];
> +
> +       /* Make sure the second kernel jumps to the correct "kernel_entry=
". */
> +       image->start =3D kernel_segment->mem + h->kernel_entry - text_off=
set;
> +
> +       kexec_dprintk("Loaded kernel at 0x%lx bufsz=3D0x%lx memsz=3D0x%lx=
\n",
> +                     kernel_segment->mem, kbuf.bufsz,
> +                     kernel_segment->memsz);
> +
> +       return NULL;
> +}
> +
> +const struct kexec_file_ops kexec_efi_ops =3D {
> +       .probe =3D efi_kexec_probe,
> +       .load =3D efi_kexec_load,
> +};
> diff --git a/arch/loongarch/kernel/machine_kexec.c b/arch/loongarch/kerne=
l/machine_kexec.c
> index f9381800e291..ba8d64bc6549 100644
> --- a/arch/loongarch/kernel/machine_kexec.c
> +++ b/arch/loongarch/kernel/machine_kexec.c
> @@ -70,18 +70,28 @@ int machine_kexec_prepare(struct kimage *kimage)
>         kimage->arch.efi_boot =3D fw_arg0;
>         kimage->arch.systable_ptr =3D fw_arg2;
>
> -       /* Find the command line */
> -       for (i =3D 0; i < kimage->nr_segments; i++) {
> -               if (!strncmp(bootloader, (char __user *)kimage->segment[i=
].buf, strlen(bootloader))) {
> -                       if (!copy_from_user(cmdline_ptr, kimage->segment[=
i].buf, COMMAND_LINE_SIZE))
> -                               kimage->arch.cmdline_ptr =3D (unsigned lo=
ng)cmdline_ptr;
> -                       break;
> +       if (kimage->file_mode =3D=3D 1) {
> +               /*
> +                * kimage->cmdline_buf will be released in kexec_file_loa=
d, so copy to
> +                * the KEXEC_CMDLINE_ADDR safe area.
> +                */
> +               memcpy((void *)KEXEC_CMDLINE_ADDR, (void *)kimage->arch.c=
mdline_ptr,
> +                                       strlen((char *)kimage->arch.cmdli=
ne_ptr) + 1);
> +               kimage->arch.cmdline_ptr =3D (unsigned long)KEXEC_CMDLINE=
_ADDR;
> +       } else {
> +               /* Find the command line */
> +               for (i =3D 0; i < kimage->nr_segments; i++) {
> +                       if (!strncmp(bootloader, (char __user *)kimage->s=
egment[i].buf, strlen(bootloader))) {
> +                               if (!copy_from_user(cmdline_ptr, kimage->=
segment[i].buf, COMMAND_LINE_SIZE))
> +                                       kimage->arch.cmdline_ptr =3D (uns=
igned long)cmdline_ptr;
> +                               break;
> +                       }
>                 }
> -       }
>
> -       if (!kimage->arch.cmdline_ptr) {
> -               pr_err("Command line not included in the provided image\n=
");
> -               return -EINVAL;
> +               if (!kimage->arch.cmdline_ptr) {
> +                       pr_err("Command line not included in the provided=
 image\n");
> +                       return -EINVAL;
> +               }
>         }
>
>         /* kexec/kdump need a safe page to save reboot_code_buffer */
> @@ -288,7 +298,8 @@ void machine_kexec(struct kimage *image)
>         local_irq_disable();
>
>         pr_notice("EFI boot flag 0x%lx\n", efi_boot);
> -       pr_notice("Command line at 0x%lx\n", cmdline_ptr);
> +       pr_notice("Command line addr at 0x%lx\n", cmdline_ptr);
> +       pr_notice("Command line: %s\n", (char *)cmdline_ptr);
Change to be like this is better:
pr_notice("EFI boot flag: 0x%lx\n", efi_boot);
pr_notice("Command line addr: 0x%lx\n", cmdline_ptr);
pr_notice("Command line string: %s\n", (char *)cmdline_ptr);

Huacai


>         pr_notice("System table at 0x%lx\n", systable_ptr);
>         pr_notice("We will call new kernel at 0x%lx\n", start_addr);
>         pr_notice("Bye ...\n");
> diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/=
kernel/machine_kexec_file.c
> new file mode 100644
> index 000000000000..a713acf32db8
> --- /dev/null
> +++ b/arch/loongarch/kernel/machine_kexec_file.c
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * kexec_file for LoongArch
> + *
> + * Author: Youling Tang <tangyouling@kylinos.cn>
> + * Copyright (C) 2025 KylinSoft Corporation.
> + *
> + * Most code is derived from LoongArch port of kexec-tools
> + */
> +
> +#define pr_fmt(fmt) "kexec_file: " fmt
> +
> +#include <linux/ioport.h>
> +#include <linux/kernel.h>
> +#include <linux/kexec.h>
> +#include <linux/memblock.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +#include <linux/vmalloc.h>
> +#include <asm/bootinfo.h>
> +
> +const struct kexec_file_ops * const kexec_file_loaders[] =3D {
> +       &kexec_efi_ops,
> +       NULL
> +};
> +
> +int arch_kimage_file_post_load_cleanup(struct kimage *image)
> +{
> +       vfree(image->elf_headers);
> +       image->elf_headers =3D NULL;
> +       image->elf_headers_sz =3D 0;
> +
> +       return kexec_image_post_load_cleanup_default(image);
> +}
> +
> +/* Adds the "initrd=3Dstart,size" command line parameter to command line=
. */
> +static void cmdline_add_initrd(struct kimage *image, unsigned long *cmdl=
ine_tmplen,
> +                               char *modified_cmdline, unsigned long ini=
trd)
> +{
> +       int initrd_strlen;
> +
> +       initrd_strlen =3D sprintf(modified_cmdline + (*cmdline_tmplen), "=
initrd=3D0x%lx,0x%lx ",
> +               initrd, image->initrd_buf_len);
> +       *cmdline_tmplen +=3D initrd_strlen;
> +}
> +
> +/*
> + * Tries to add the initrd to the image. If it is not possible to find
> + * valid locations, this function will undo changes to the image and ret=
urn non
> + * zero.
> + */
> +int load_other_segments(struct kimage *image,
> +                       unsigned long kernel_load_addr,
> +                       unsigned long kernel_size,
> +                       char *initrd, unsigned long initrd_len,
> +                       char *cmdline, unsigned long cmdline_len)
> +{
> +       struct kexec_buf kbuf;
> +       unsigned long orig_segments =3D image->nr_segments;
> +       char *modified_cmdline =3D NULL;
> +       unsigned long cmdline_tmplen =3D 0;
> +       unsigned long initrd_load_addr =3D 0;
> +       int ret =3D 0;
> +
> +
> +       kbuf.image =3D image;
> +       /* not allocate anything below the kernel */
> +       kbuf.buf_min =3D kernel_load_addr + kernel_size;
> +
> +       modified_cmdline =3D kzalloc(COMMAND_LINE_SIZE, GFP_KERNEL);
> +       if (!modified_cmdline)
> +               return -EINVAL;
> +
> +       /* Ensure it's nul terminated */
> +       modified_cmdline[COMMAND_LINE_SIZE - 1] =3D '\0';
> +
> +       /* load initrd */
> +       if (initrd) {
> +               kbuf.buffer =3D initrd;
> +               kbuf.bufsz =3D initrd_len;
> +               kbuf.mem =3D KEXEC_BUF_MEM_UNKNOWN;
> +               kbuf.memsz =3D initrd_len;
> +               kbuf.buf_align =3D 0;
> +               /* within 1GB-aligned window of up to 32GB in size */
> +               kbuf.buf_max =3D round_down(kernel_load_addr, SZ_1G)
> +                                               + (unsigned long)SZ_1G * =
32;
> +               kbuf.top_down =3D false;
> +
> +               ret =3D kexec_add_buffer(&kbuf);
> +               if (ret)
> +                       goto out_err;
> +               initrd_load_addr =3D kbuf.mem;
> +
> +               kexec_dprintk("Loaded initrd at 0x%lx bufsz=3D0x%lx memsz=
=3D0x%lx\n",
> +                             initrd_load_addr, kbuf.bufsz, kbuf.memsz);
> +
> +               /* Add the initrd=3Dstart,size parameter to the command l=
ine */
> +               cmdline_add_initrd(image, &cmdline_tmplen, modified_cmdli=
ne, initrd_load_addr);
> +       }
> +
> +       if (cmdline_len + cmdline_tmplen > COMMAND_LINE_SIZE) {
> +               pr_err("Appending command line exceeds cmdline size\n");
> +               ret =3D -EINVAL;
> +               goto out_err;
> +       }
> +       memcpy(modified_cmdline + cmdline_tmplen, cmdline, cmdline_len);
> +       cmdline =3D modified_cmdline;
> +       image->arch.cmdline_ptr =3D (unsigned long)cmdline;
> +
> +       return 0;
> +
> +out_err:
> +       image->nr_segments =3D orig_segments;
> +       kfree(modified_cmdline);
> +       return ret;
> +}
> --
> 2.43.0
>

