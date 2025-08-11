Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6589CA0EC4
	for <kexec@archiver.kernel.org>; Mon, 11 Aug 2025 15:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wcMvyumn+o9yi94yzPHbAOq0CaF3HO5hmjQ0Hjqxku8=; b=3LyAhrbliAs5FHkX2MTMDT13pO
	G6YOUUeXgYC09maOM1bbi2kOpEwEyPqH56Xkup/G8G0CT1N47XfDBlTWVUCN3QX3oF3V8S3SKKVwv
	OmOjzKKelwOFpwjs4BmtvlbnVbKJykGb4PEC6DUDmATUGNkjxpwZfF7CfF5C2xJlC3AjL9ohZy8Ws
	PtuZuAslGHmfE1sifEm95hxtiaW89aWVesgsJtUEIjIhBScm1mFWnpCSVocsrIXMIWCxlo6Ppf+1k
	RcOEy4txmGWuVKFiZ2uFupnjjIAk+x+YUOPweSrdLy5JIBg7RwVzQuMbktwvZHHvMHL/xR0XVZB2t
	2ya+rfLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulUl0-00000008G5j-3CG7;
	Mon, 11 Aug 2025 15:48:18 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulTBz-00000007xG1-2A27
	for kexec@lists.infradead.org;
	Mon, 11 Aug 2025 14:08:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D7E5E613AE
	for <kexec@lists.infradead.org>; Mon, 11 Aug 2025 14:08:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8327AC4CEED
	for <kexec@lists.infradead.org>; Mon, 11 Aug 2025 14:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754921282;
	bh=mmglv790KGYDyohM6cmLFFriSeuAx7IxQWdGKZS5/ak=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qHtq1ZCMcp5T5QZ2uBm1wwv1TViLXYR7pztOFJVjrALKti2s9Punj4v43dMFmH5Vj
	 DA5QsNK1so3O2sDR2gOiG5zELJ4VLpXxneUjSYqZwOgyTl0qx4S0X6kEt67HeRtDVd
	 cvg9RDnB9Xq4owT/WlKfed27GumPejXNgWYlluYvOfm3OOIB2wSSB014FJ7CVbThL2
	 Ny8FhNJ7GW1XTOy6cyjV65F6X8ZGjFYfocPJQQFr0pUPRDq2kKC89CP2eO+sTwFdjm
	 o8v2h/uO7VJ1PW3F4ljMqFY8lbbp34tr6SYJea5nve+O+/+001VL/VTPbp0l25qZo0
	 /TD+OGuyNWRHA==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-615622ed70fso7092300a12.3
        for <kexec@lists.infradead.org>; Mon, 11 Aug 2025 07:08:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXPLnrNB5gGsK1D2UAM/uvMAVQXmNA5AzJ1A1TitCS8o9X6kIMFMteZqXQ0zLfFREaZ2vlYvQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzLO9iYfKn6ck2NAfUpSIuhxpESBhhhXzrTEni4zwKLy7UWAOm1
	PqjnOiovbEb6FSYe0R/t8aJWKOKVyglbCMF5/qZDYjDHqnBkFP3li/ZOwt0IWpxOpp+ldAxddaZ
	f0I/uFmYsVSqM+rAXZoqjMUS9wbslJK0=
X-Google-Smtp-Source: AGHT+IFBi4foYHAxmU5BEbts5BEj/H+5zlsoTVLd0teYehjXCYtNHa7BIsgXrMBiPdLbDdPTjzWQElkO3PR5kW7Zk30=
X-Received: by 2002:a05:6402:5250:b0:618:b9e:4d46 with SMTP id
 4fb4d7f45d1cf-6180b9e4f32mr6160019a12.6.1754921280990; Mon, 11 Aug 2025
 07:08:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250811092659.14903-1-youling.tang@linux.dev> <20250811092659.14903-3-youling.tang@linux.dev>
In-Reply-To: <20250811092659.14903-3-youling.tang@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 11 Aug 2025 22:07:36 +0800
X-Gmail-Original-Message-ID: <CAAhV-H55n=v+ztBc8UgK339kuhg3LKvcOQu+jhpVrbvO3zf3=g@mail.gmail.com>
X-Gm-Features: Ac12FXx3wygiT0KUxDdTLKBIqdJd8ge_J4YtkVREbi-861CaXIwjYcJ3xA7tgyU
Message-ID: <CAAhV-H55n=v+ztBc8UgK339kuhg3LKvcOQu+jhpVrbvO3zf3=g@mail.gmail.com>
Subject: Re: [PATCH 2/6] LoongArch: Add kexec_file support
To: Youling Tang <youling.tang@linux.dev>
Cc: WANG Xuerui <kernel@xen0n.name>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Youling Tang <tangyouling@kylinos.cn>
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

Hi, Youling,

On Mon, Aug 11, 2025 at 5:28=E2=80=AFPM Youling Tang <youling.tang@linux.de=
v> wrote:
>
> From: Youling Tang <tangyouling@kylinos.cn>
>
> This patch adds support for kexec_file on LoongArch.
>
> The image_load() as two parts:
> - the first part loads the kernel image (vmlinuz.efi or vmlinux.efi)
> - the second part loads other segments (eg: initrd, cmdline)
>
> Currently, pez(vmlinuz.efi) and pei(vmlinux.efi) format images are suppor=
ted,
> but ELF format is not supported.
>
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> ---
>  arch/loongarch/Kconfig                     |   8 ++
>  arch/loongarch/include/asm/image.h         |  18 ++++
>  arch/loongarch/include/asm/kexec.h         |  12 +++
>  arch/loongarch/kernel/Makefile             |   1 +
>  arch/loongarch/kernel/kexec_image.c        | 112 +++++++++++++++++++++
>  arch/loongarch/kernel/machine_kexec.c      |  33 ++++--
>  arch/loongarch/kernel/machine_kexec_file.c |  46 +++++++++
>  7 files changed, 219 insertions(+), 11 deletions(-)
>  create mode 100644 arch/loongarch/kernel/kexec_image.c
>  create mode 100644 arch/loongarch/kernel/machine_kexec_file.c
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index f0abc38c40ac..fd50c83f7827 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -625,6 +625,14 @@ config CPU_HAS_PREFETCH
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
> +
>  config ARCH_SUPPORTS_CRASH_DUMP
>         def_bool y
>
> diff --git a/arch/loongarch/include/asm/image.h b/arch/loongarch/include/=
asm/image.h
> index 1f090736e71d..829e1ecb1f5d 100644
> --- a/arch/loongarch/include/asm/image.h
> +++ b/arch/loongarch/include/asm/image.h
> @@ -36,5 +36,23 @@ struct loongarch_image_header {
>         uint32_t pe_header;
>  };
>
> +static const uint8_t loongarch_image_pe_sig[2] =3D {'M', 'Z'};
> +static const uint8_t loongarch_pe_machtype[6] =3D {'P', 'E', 0x0, 0x0, 0=
x64, 0x62};
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
> index cf95cd3eb2de..3ef8517a3670 100644
> --- a/arch/loongarch/include/asm/kexec.h
> +++ b/arch/loongarch/include/asm/kexec.h
> @@ -41,6 +41,18 @@ struct kimage_arch {
>         unsigned long systable_ptr;
>  };
>
> +#ifdef CONFIG_KEXEC_FILE
> +extern const struct kexec_file_ops kexec_image_ops;
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
I think the RISC-V naming "load_extra_segments" is better.

> +#endif
> +
>  typedef void (*do_kexec_t)(unsigned long efi_boot,
>                            unsigned long cmdline_ptr,
>                            unsigned long systable_ptr,
> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makef=
ile
> index 6f5a4574a911..bd9405ee3888 100644
> --- a/arch/loongarch/kernel/Makefile
> +++ b/arch/loongarch/kernel/Makefile
> @@ -62,6 +62,7 @@ obj-$(CONFIG_MAGIC_SYSRQ)     +=3D sysrq.o
>  obj-$(CONFIG_RELOCATABLE)      +=3D relocate.o
>
>  obj-$(CONFIG_KEXEC_CORE)       +=3D machine_kexec.o relocate_kernel.o
> +obj-$(CONFIG_KEXEC_FILE)       +=3D machine_kexec_file.o kexec_image.o
We only support the efi format, so we don't need to split a
kexec_image.c like RISC-V, just put everything into
machine_kexec_file.c is OK.

Huacai

>  obj-$(CONFIG_CRASH_DUMP)       +=3D crash_dump.o
>
>  obj-$(CONFIG_UNWINDER_GUESS)   +=3D unwind_guess.o
> diff --git a/arch/loongarch/kernel/kexec_image.c b/arch/loongarch/kernel/=
kexec_image.c
> new file mode 100644
> index 000000000000..fdd1845b4e2e
> --- /dev/null
> +++ b/arch/loongarch/kernel/kexec_image.c
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Kexec image loader for LoongArch
> +
> + * Author: Youling Tang <tangyouling@kylinos.cn>
> + * Copyright (C) 2025 KylinSoft Corporation.
> + */
> +
> +#define pr_fmt(fmt)    "kexec_file(Image): " fmt
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
> +static int image_probe(const char *kernel_buf, unsigned long kernel_len)
> +{
> +       const struct loongarch_image_header *h =3D
> +               (const struct loongarch_image_header *)(kernel_buf);
> +
> +       if (!h || (kernel_len < sizeof(*h))) {
> +               pr_err("No loongarch image header.\n");
> +               return -EINVAL;
> +       }
> +
> +       if (!loongarch_header_check_pe_sig(h)) {
> +               pr_err("Bad loongarch PE image header.\n");
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static void *image_load(struct kimage *image,
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
> +       kbuf.buf_min =3D 0;
> +       kbuf.buf_max =3D ULONG_MAX;
> +       kbuf.top_down =3D false;
> +
> +       kbuf.buffer =3D kernel;
> +       kbuf.bufsz =3D kernel_len;
> +       kbuf.mem =3D KEXEC_BUF_MEM_UNKNOWN;
> +       kbuf.memsz =3D le64_to_cpu(h->image_size);
> +       text_offset =3D le64_to_cpu(h->text_offset);
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
> +const struct kexec_file_ops kexec_image_ops =3D {
> +       .probe =3D image_probe,
> +       .load =3D image_load,
> +};
> diff --git a/arch/loongarch/kernel/machine_kexec.c b/arch/loongarch/kerne=
l/machine_kexec.c
> index f9381800e291..008f43e26120 100644
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
> +       pr_notice("Command line at %s\n", (char *)cmdline_ptr);
>         pr_notice("System table at 0x%lx\n", systable_ptr);
>         pr_notice("We will call new kernel at 0x%lx\n", start_addr);
>         pr_notice("Bye ...\n");
> diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/=
kernel/machine_kexec_file.c
> new file mode 100644
> index 000000000000..bc91ae0afa4c
> --- /dev/null
> +++ b/arch/loongarch/kernel/machine_kexec_file.c
> @@ -0,0 +1,46 @@
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
> +       &kexec_image_ops,
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
> +int load_other_segments(struct kimage *image,
> +                       unsigned long kernel_load_addr,
> +                       unsigned long kernel_size,
> +                       char *initrd, unsigned long initrd_len,
> +                       char *cmdline, unsigned long cmdline_len)
> +{
> +       image->arch.cmdline_ptr =3D (unsigned long)cmdline;
> +
> +       return 0;
> +}
> --
> 2.34.1
>

