Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118B5CA0EC4
	for <kexec@archiver.kernel.org>; Tue, 12 Aug 2025 02:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e0jjc1Qh9l/TtbSp/DvQc8dp3u63DgKH6dC+ccyTGrA=; b=4fllhacor8Qtl+FMeUbhedObOW
	Bqb9vwknA04dpzjzDhnk6L4EcseIhUQF6D3BHHqojt+QB5bIggrpONqZz+9bXoDrMgGWGp/4v2jiL
	cIDEvB2nSlsH11Rt23HFYRGAxr1+Rno1CiwUBnGOd0d/Sac4zIMu2KujtYl78Uc+dcVRVC+CeJiIY
	MShmabMOLVJA4Ny6tDC45ISf9l+yDJ3e1DsI4KTwFciWUT/8xlYMC1i4env9rDDQXC4r7FOA/75Uz
	G5uCo/fttlXYvaGsZ4zREq8jqIrAn3egyklWlIbfzPYIO30FsMsYc5RaioghSW4cCY3/iORnRcZZl
	Z+lIimHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulf8n-00000009dnJ-1KOQ;
	Tue, 12 Aug 2025 02:53:33 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulf8l-00000009dmx-1To6
	for kexec@lists.infradead.org;
	Tue, 12 Aug 2025 02:53:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A82AE5C6239
	for <kexec@lists.infradead.org>; Tue, 12 Aug 2025 02:53:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8D9C4CEF8
	for <kexec@lists.infradead.org>; Tue, 12 Aug 2025 02:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754967210;
	bh=WBqMhn0dr1v/RbRGaFLNOqrPlnpON2QAc5xhxdJTMh4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KGa2ayegmBJtemPjpSSfjXP6qO0jHOZ/tjdW6g8mt+m6F7EqHH28/CNSkKv4W65YK
	 K2ONCFXd8iejAdXrPrWSBYZB0D7y9sWTVQmPLWeHix4fA3Nl443A+yjOMmJX0CBbMx
	 MqGcRVeNda3+RGINb4IL9mPOBzvU2QLurIOkzatatz1UleAw8JcAxZaWFYktJfTSgB
	 zXzMKCTYywH+d5HSlelVf6AX8SjuKxR98oE//XHi8DzXvymIBbKp1w876W3yOvb5aC
	 Gs3WwjrHW6F27NDUhY+JgzsKLEDfWw5FkjBjskiiSTRUQl1hAZXkNMuijpvJg1vGfk
	 VpDEEIYQLJVwg==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-615622ed70fso7992511a12.3
        for <kexec@lists.infradead.org>; Mon, 11 Aug 2025 19:53:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVJAW4CUd+0juPCvisuE3yacVbSADupMWquWTljMGJF1n7Fv4rG3b9hz3/CUsAylY+c0HS1sw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzWcOoK0P0b0291aSi3TMmCiW3atYl8m7kf1Ptjg8YWs0Z0C4J8
	yCkXen9CM9jFvjRuaDihkPuVMIilXHhorhHJRyo1ympxvSk9KeD8nNtsAm833272xtgFHohWQI7
	NHIYiytDVb8eNkXy6iW+QJtomdYUoQME=
X-Google-Smtp-Source: AGHT+IEYPqssne4y0mdwj5WWZ8Qz5EOzodhaYqklShMYc1Z0tWG1nQ55YTMdxLzKJRULrn1HgmVfxgTq2NCGqVi6GxM=
X-Received: by 2002:a05:6402:2550:b0:615:38e6:b739 with SMTP id
 4fb4d7f45d1cf-6184ec55e5fmr1324064a12.10.1754967208687; Mon, 11 Aug 2025
 19:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250811092659.14903-1-youling.tang@linux.dev>
 <20250811092659.14903-3-youling.tang@linux.dev> <CAAhV-H55n=v+ztBc8UgK339kuhg3LKvcOQu+jhpVrbvO3zf3=g@mail.gmail.com>
 <9760e574-3eb0-46b2-bccd-916f73b9c39e@linux.dev>
In-Reply-To: <9760e574-3eb0-46b2-bccd-916f73b9c39e@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 12 Aug 2025 10:53:16 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5Q9hjKX8h4shD01Omsb0-dF=pR3_QKrLai=iWYW4=XQA@mail.gmail.com>
X-Gm-Features: Ac12FXw9quKvGV-iA4gecqdDd9xCJmmA-Txklg3yjtIoPYvKLFuK-MwgwDB6mHw
Message-ID: <CAAhV-H5Q9hjKX8h4shD01Omsb0-dF=pR3_QKrLai=iWYW4=XQA@mail.gmail.com>
Subject: Re: [PATCH 2/6] LoongArch: Add kexec_file support
To: Youling Tang <youling.tang@linux.dev>
Cc: WANG Xuerui <kernel@xen0n.name>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Youling Tang <tangyouling@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250811_195331_493598_D24E294C 
X-CRM114-Status: GOOD (  42.32  )
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

On Tue, Aug 12, 2025 at 9:22=E2=80=AFAM Youling Tang <youling.tang@linux.de=
v> wrote:
>
> Hi, Huacai
> On 2025/8/11 22:07, Huacai Chen wrote:
> > Hi, Youling,
> >
> > On Mon, Aug 11, 2025 at 5:28=E2=80=AFPM Youling Tang <youling.tang@linu=
x.dev> wrote:
> >> From: Youling Tang <tangyouling@kylinos.cn>
> >>
> >> This patch adds support for kexec_file on LoongArch.
> >>
> >> The image_load() as two parts:
> >> - the first part loads the kernel image (vmlinuz.efi or vmlinux.efi)
> >> - the second part loads other segments (eg: initrd, cmdline)
> >>
> >> Currently, pez(vmlinuz.efi) and pei(vmlinux.efi) format images are sup=
ported,
> >> but ELF format is not supported.
> >>
> >> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> >> ---
> >>   arch/loongarch/Kconfig                     |   8 ++
> >>   arch/loongarch/include/asm/image.h         |  18 ++++
> >>   arch/loongarch/include/asm/kexec.h         |  12 +++
> >>   arch/loongarch/kernel/Makefile             |   1 +
> >>   arch/loongarch/kernel/kexec_image.c        | 112 +++++++++++++++++++=
++
> >>   arch/loongarch/kernel/machine_kexec.c      |  33 ++++--
> >>   arch/loongarch/kernel/machine_kexec_file.c |  46 +++++++++
> >>   7 files changed, 219 insertions(+), 11 deletions(-)
> >>   create mode 100644 arch/loongarch/kernel/kexec_image.c
> >>   create mode 100644 arch/loongarch/kernel/machine_kexec_file.c
> >>
> >> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> >> index f0abc38c40ac..fd50c83f7827 100644
> >> --- a/arch/loongarch/Kconfig
> >> +++ b/arch/loongarch/Kconfig
> >> @@ -625,6 +625,14 @@ config CPU_HAS_PREFETCH
> >>   config ARCH_SUPPORTS_KEXEC
> >>          def_bool y
> >>
> >> +config ARCH_SUPPORTS_KEXEC_FILE
> >> +       def_bool 64BIT
> >> +
> >> +config ARCH_SELECTS_KEXEC_FILE
> >> +       def_bool y
> >> +       depends on KEXEC_FILE
> >> +       select HAVE_IMA_KEXEC if IMA
> >> +
> >>   config ARCH_SUPPORTS_CRASH_DUMP
> >>          def_bool y
> >>
> >> diff --git a/arch/loongarch/include/asm/image.h b/arch/loongarch/inclu=
de/asm/image.h
> >> index 1f090736e71d..829e1ecb1f5d 100644
> >> --- a/arch/loongarch/include/asm/image.h
> >> +++ b/arch/loongarch/include/asm/image.h
> >> @@ -36,5 +36,23 @@ struct loongarch_image_header {
> >>          uint32_t pe_header;
> >>   };
> >>
> >> +static const uint8_t loongarch_image_pe_sig[2] =3D {'M', 'Z'};
> >> +static const uint8_t loongarch_pe_machtype[6] =3D {'P', 'E', 0x0, 0x0=
, 0x64, 0x62};
> >> +
> >> +/**
> >> + * loongarch_header_check_pe_sig - Helper to check the loongarch imag=
e header.
> >> + *
> >> + * Returns non-zero if 'MZ' signature is found.
> >> + */
> >> +
> >> +static inline int loongarch_header_check_pe_sig(const struct loongarc=
h_image_header *h)
> >> +{
> >> +       if (!h)
> >> +               return 0;
> >> +
> >> +       return (h->pe_sig[0] =3D=3D loongarch_image_pe_sig[0]
> >> +               && h->pe_sig[1] =3D=3D loongarch_image_pe_sig[1]);
> >> +}
> >> +
> >>   #endif /* __ASSEMBLY__ */
> >>   #endif /* __ASM_IMAGE_H */
> >> diff --git a/arch/loongarch/include/asm/kexec.h b/arch/loongarch/inclu=
de/asm/kexec.h
> >> index cf95cd3eb2de..3ef8517a3670 100644
> >> --- a/arch/loongarch/include/asm/kexec.h
> >> +++ b/arch/loongarch/include/asm/kexec.h
> >> @@ -41,6 +41,18 @@ struct kimage_arch {
> >>          unsigned long systable_ptr;
> >>   };
> >>
> >> +#ifdef CONFIG_KEXEC_FILE
> >> +extern const struct kexec_file_ops kexec_image_ops;
> >> +
> >> +int arch_kimage_file_post_load_cleanup(struct kimage *image);
> >> +#define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load=
_cleanup
> >> +
> >> +extern int load_other_segments(struct kimage *image,
> >> +               unsigned long kernel_load_addr, unsigned long kernel_s=
ize,
> >> +               char *initrd, unsigned long initrd_len,
> >> +               char *cmdline, unsigned long cmdline_len);
> > I think the RISC-V naming "load_extra_segments" is better.
> This name is also fine, but I prefer it to be consistent with
> that in kexec-tools.
OK, then you can keep your original name.

> >
> >> +#endif
> >> +
> >>   typedef void (*do_kexec_t)(unsigned long efi_boot,
> >>                             unsigned long cmdline_ptr,
> >>                             unsigned long systable_ptr,
> >> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Ma=
kefile
> >> index 6f5a4574a911..bd9405ee3888 100644
> >> --- a/arch/loongarch/kernel/Makefile
> >> +++ b/arch/loongarch/kernel/Makefile
> >> @@ -62,6 +62,7 @@ obj-$(CONFIG_MAGIC_SYSRQ)     +=3D sysrq.o
> >>   obj-$(CONFIG_RELOCATABLE)      +=3D relocate.o
> >>
> >>   obj-$(CONFIG_KEXEC_CORE)       +=3D machine_kexec.o relocate_kernel.=
o
> >> +obj-$(CONFIG_KEXEC_FILE)       +=3D machine_kexec_file.o kexec_image.=
o
> > We only support the efi format, so we don't need to split a
> > kexec_image.c like RISC-V, just put everything into
> > machine_kexec_file.c is OK.
> I hope it is separated and consistent with other architectures.
> For instance, arm64 only supports one type.
It seems only ARM64 and RISC-V are consistent, x86/powerpc/parisc are not.

Huacai

>
> Youling.
> >
> > Huacai
> >
> >>   obj-$(CONFIG_CRASH_DUMP)       +=3D crash_dump.o
> >>
> >>   obj-$(CONFIG_UNWINDER_GUESS)   +=3D unwind_guess.o
> >> diff --git a/arch/loongarch/kernel/kexec_image.c b/arch/loongarch/kern=
el/kexec_image.c
> >> new file mode 100644
> >> index 000000000000..fdd1845b4e2e
> >> --- /dev/null
> >> +++ b/arch/loongarch/kernel/kexec_image.c
> >> @@ -0,0 +1,112 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Kexec image loader for LoongArch
> >> +
> >> + * Author: Youling Tang <tangyouling@kylinos.cn>
> >> + * Copyright (C) 2025 KylinSoft Corporation.
> >> + */
> >> +
> >> +#define pr_fmt(fmt)    "kexec_file(Image): " fmt
> >> +
> >> +#include <linux/err.h>
> >> +#include <linux/errno.h>
> >> +#include <linux/kernel.h>
> >> +#include <linux/kexec.h>
> >> +#include <linux/pe.h>
> >> +#include <linux/string.h>
> >> +#include <asm/byteorder.h>
> >> +#include <asm/cpufeature.h>
> >> +#include <asm/image.h>
> >> +
> >> +static int image_probe(const char *kernel_buf, unsigned long kernel_l=
en)
> >> +{
> >> +       const struct loongarch_image_header *h =3D
> >> +               (const struct loongarch_image_header *)(kernel_buf);
> >> +
> >> +       if (!h || (kernel_len < sizeof(*h))) {
> >> +               pr_err("No loongarch image header.\n");
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       if (!loongarch_header_check_pe_sig(h)) {
> >> +               pr_err("Bad loongarch PE image header.\n");
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static void *image_load(struct kimage *image,
> >> +                               char *kernel, unsigned long kernel_len=
,
> >> +                               char *initrd, unsigned long initrd_len=
,
> >> +                               char *cmdline, unsigned long cmdline_l=
en)
> >> +{
> >> +       struct loongarch_image_header *h;
> >> +       struct kexec_buf kbuf;
> >> +       unsigned long text_offset, kernel_segment_number;
> >> +       struct kexec_segment *kernel_segment;
> >> +       int ret;
> >> +
> >> +       h =3D (struct loongarch_image_header *)kernel;
> >> +       if (!h->image_size)
> >> +               return ERR_PTR(-EINVAL);
> >> +
> >> +       /* Load the kernel */
> >> +       kbuf.image =3D image;
> >> +       kbuf.buf_min =3D 0;
> >> +       kbuf.buf_max =3D ULONG_MAX;
> >> +       kbuf.top_down =3D false;
> >> +
> >> +       kbuf.buffer =3D kernel;
> >> +       kbuf.bufsz =3D kernel_len;
> >> +       kbuf.mem =3D KEXEC_BUF_MEM_UNKNOWN;
> >> +       kbuf.memsz =3D le64_to_cpu(h->image_size);
> >> +       text_offset =3D le64_to_cpu(h->text_offset);
> >> +       kbuf.buf_align =3D SZ_2M;
> >> +
> >> +       kernel_segment_number =3D image->nr_segments;
> >> +
> >> +       /*
> >> +        * The location of the kernel segment may make it impossible t=
o satisfy
> >> +        * the other segment requirements, so we try repeatedly to fin=
d a
> >> +        * location that will work.
> >> +        */
> >> +       while ((ret =3D kexec_add_buffer(&kbuf)) =3D=3D 0) {
> >> +               /* Try to load additional data */
> >> +               kernel_segment =3D &image->segment[kernel_segment_numb=
er];
> >> +               ret =3D load_other_segments(image, kernel_segment->mem=
,
> >> +                                         kernel_segment->memsz, initr=
d,
> >> +                                         initrd_len, cmdline, cmdline=
_len);
> >> +               if (!ret)
> >> +                       break;
> >> +
> >> +               /*
> >> +                * We couldn't find space for the other segments; eras=
e the
> >> +                * kernel segment and try the next available hole.
> >> +                */
> >> +               image->nr_segments -=3D 1;
> >> +               kbuf.buf_min =3D kernel_segment->mem + kernel_segment-=
>memsz;
> >> +               kbuf.mem =3D KEXEC_BUF_MEM_UNKNOWN;
> >> +       }
> >> +
> >> +       if (ret) {
> >> +               pr_err("Could not find any suitable kernel location!")=
;
> >> +               return ERR_PTR(ret);
> >> +       }
> >> +
> >> +       kernel_segment =3D &image->segment[kernel_segment_number];
> >> +
> >> +       /* Make sure the second kernel jumps to the correct "kernel_en=
try". */
> >> +       image->start =3D kernel_segment->mem + h->kernel_entry - text_=
offset;
> >> +
> >> +       kexec_dprintk("Loaded kernel at 0x%lx bufsz=3D0x%lx memsz=3D0x=
%lx\n",
> >> +                     kernel_segment->mem, kbuf.bufsz,
> >> +                     kernel_segment->memsz);
> >> +
> >> +       return NULL;
> >> +}
> >> +
> >> +const struct kexec_file_ops kexec_image_ops =3D {
> >> +       .probe =3D image_probe,
> >> +       .load =3D image_load,
> >> +};
> >> diff --git a/arch/loongarch/kernel/machine_kexec.c b/arch/loongarch/ke=
rnel/machine_kexec.c
> >> index f9381800e291..008f43e26120 100644
> >> --- a/arch/loongarch/kernel/machine_kexec.c
> >> +++ b/arch/loongarch/kernel/machine_kexec.c
> >> @@ -70,18 +70,28 @@ int machine_kexec_prepare(struct kimage *kimage)
> >>          kimage->arch.efi_boot =3D fw_arg0;
> >>          kimage->arch.systable_ptr =3D fw_arg2;
> >>
> >> -       /* Find the command line */
> >> -       for (i =3D 0; i < kimage->nr_segments; i++) {
> >> -               if (!strncmp(bootloader, (char __user *)kimage->segmen=
t[i].buf, strlen(bootloader))) {
> >> -                       if (!copy_from_user(cmdline_ptr, kimage->segme=
nt[i].buf, COMMAND_LINE_SIZE))
> >> -                               kimage->arch.cmdline_ptr =3D (unsigned=
 long)cmdline_ptr;
> >> -                       break;
> >> +       if (kimage->file_mode =3D=3D 1) {
> >> +               /*
> >> +                * kimage->cmdline_buf will be released in kexec_file_=
load, so copy to
> >> +                * the KEXEC_CMDLINE_ADDR safe area.
> >> +                */
> >> +               memcpy((void *)KEXEC_CMDLINE_ADDR, (void *)kimage->arc=
h.cmdline_ptr,
> >> +                                       strlen((char *)kimage->arch.cm=
dline_ptr) + 1);
> >> +               kimage->arch.cmdline_ptr =3D (unsigned long)KEXEC_CMDL=
INE_ADDR;
> >> +       } else {
> >> +               /* Find the command line */
> >> +               for (i =3D 0; i < kimage->nr_segments; i++) {
> >> +                       if (!strncmp(bootloader, (char __user *)kimage=
->segment[i].buf, strlen(bootloader))) {
> >> +                               if (!copy_from_user(cmdline_ptr, kimag=
e->segment[i].buf, COMMAND_LINE_SIZE))
> >> +                                       kimage->arch.cmdline_ptr =3D (=
unsigned long)cmdline_ptr;
> >> +                               break;
> >> +                       }
> >>                  }
> >> -       }
> >>
> >> -       if (!kimage->arch.cmdline_ptr) {
> >> -               pr_err("Command line not included in the provided imag=
e\n");
> >> -               return -EINVAL;
> >> +               if (!kimage->arch.cmdline_ptr) {
> >> +                       pr_err("Command line not included in the provi=
ded image\n");
> >> +                       return -EINVAL;
> >> +               }
> >>          }
> >>
> >>          /* kexec/kdump need a safe page to save reboot_code_buffer */
> >> @@ -288,7 +298,8 @@ void machine_kexec(struct kimage *image)
> >>          local_irq_disable();
> >>
> >>          pr_notice("EFI boot flag 0x%lx\n", efi_boot);
> >> -       pr_notice("Command line at 0x%lx\n", cmdline_ptr);
> >> +       pr_notice("Command line addr at 0x%lx\n", cmdline_ptr);
> >> +       pr_notice("Command line at %s\n", (char *)cmdline_ptr);
> >>          pr_notice("System table at 0x%lx\n", systable_ptr);
> >>          pr_notice("We will call new kernel at 0x%lx\n", start_addr);
> >>          pr_notice("Bye ...\n");
> >> diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongar=
ch/kernel/machine_kexec_file.c
> >> new file mode 100644
> >> index 000000000000..bc91ae0afa4c
> >> --- /dev/null
> >> +++ b/arch/loongarch/kernel/machine_kexec_file.c
> >> @@ -0,0 +1,46 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * kexec_file for LoongArch
> >> + *
> >> + * Author: Youling Tang <tangyouling@kylinos.cn>
> >> + * Copyright (C) 2025 KylinSoft Corporation.
> >> + *
> >> + * Most code is derived from LoongArch port of kexec-tools
> >> + */
> >> +
> >> +#define pr_fmt(fmt) "kexec_file: " fmt
> >> +
> >> +#include <linux/ioport.h>
> >> +#include <linux/kernel.h>
> >> +#include <linux/kexec.h>
> >> +#include <linux/memblock.h>
> >> +#include <linux/slab.h>
> >> +#include <linux/string.h>
> >> +#include <linux/types.h>
> >> +#include <linux/vmalloc.h>
> >> +#include <asm/bootinfo.h>
> >> +
> >> +const struct kexec_file_ops * const kexec_file_loaders[] =3D {
> >> +       &kexec_image_ops,
> >> +       NULL
> >> +};
> >> +
> >> +int arch_kimage_file_post_load_cleanup(struct kimage *image)
> >> +{
> >> +       vfree(image->elf_headers);
> >> +       image->elf_headers =3D NULL;
> >> +       image->elf_headers_sz =3D 0;
> >> +
> >> +       return kexec_image_post_load_cleanup_default(image);
> >> +}
> >> +
> >> +int load_other_segments(struct kimage *image,
> >> +                       unsigned long kernel_load_addr,
> >> +                       unsigned long kernel_size,
> >> +                       char *initrd, unsigned long initrd_len,
> >> +                       char *cmdline, unsigned long cmdline_len)
> >> +{
> >> +       image->arch.cmdline_ptr =3D (unsigned long)cmdline;
> >> +
> >> +       return 0;
> >> +}
> >> --
> >> 2.34.1
> >>

