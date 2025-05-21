Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2BA4C2D0CD
	for <kexec@archiver.kernel.org>; Wed, 21 May 2025 07:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=quqMfHb/r0GEfRAytiJ8y5i6vS+/NlcJRf4bURtaGOQ=; b=lyED3uU6nK8WnlUnTzMeTE/jMP
	UbfrmFRVmuJRtZN8sLjG0Mo7SJ9CKd1N3wzzs40AaMgFDCs+zDqPqrNIJPyZhjn3XKtiRxJEDbQrU
	2SPfOLFbZPFRg4vdD0H7/W8FRw52YlotYht9hfSt65F3BMsLB0MtOgP2ro7kXWL8QTgJ3/rG2ElKs
	Syz7eUpsrBKa4yLRcTzRbDT9a3KB2CAlATrGUZ8xxZEE0bAFwnmTUP+8SERH8BS74mIZtVt7yOnBG
	G0mWmSWs/TJGDxoSQJ6E6QWZ6FgLFlyiJewsQuB03wGQLYhP8+cNR3rDfRtQRl/EhLmRGuw50w1bX
	nroElQ/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHeDG-0000000F6Ou-1Qyv;
	Wed, 21 May 2025 07:50:06 +0000
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHeBO-0000000F68H-2rCL
	for kexec@lists.infradead.org;
	Wed, 21 May 2025 07:48:12 +0000
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-54afb5fcebaso7644161e87.3
        for <kexec@lists.infradead.org>; Wed, 21 May 2025 00:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1747813685; x=1748418485; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=quqMfHb/r0GEfRAytiJ8y5i6vS+/NlcJRf4bURtaGOQ=;
        b=EFCe6UapcL5gdmRWvk9iT4cActNW/LpAajxYFovX2nEOqm77/B2L7G5bl8lNOlwSgd
         hB5JY5Cgtvw6CgZ+4+ezGBxFtyoYaf2g9ETSf52mlzJ+wNHlnzkVEs+dKB5qu8a5nElG
         WplxK9Jc6sNjfrF+CUJj+tA8nmuRMI9rMGPuweFEcmb3Fob+5E+C2mPZk1VYvSgBsbGf
         mhLQc8j1ukv89NQU1x8RcG52RPCqnk4rDLWdS+VBrLArYPBAqkCdIBmXB/rjJOYHmAJk
         v5P0yHpSRRa+Q9044roLh+iTaaldJ7SOeN6kmGI+1GnDyry1lwYyQiGVPGoJOjMco/TL
         fsDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747813685; x=1748418485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=quqMfHb/r0GEfRAytiJ8y5i6vS+/NlcJRf4bURtaGOQ=;
        b=CrQ9AfCD2935hmg6xV229n4xch8oDLdLwb5y9SDoI5IYRPCFm26f6tb+6xfyeu9WZw
         wzwCJDJbLmVNUHOtKThmP4XIV6CRPLzHzeCIPC/lrUov3vEstKsJ6IhbzOuhig/RKZOD
         +qo/6uz8qGUJKTk2joYMUB4y+nP2GS3gj2QAZDLc7vcQQeCMQwKqJLDYccatoExznfC1
         07kjCow4WHQ9Xr2TErq1iKwVLKT1lKnGiH/OPvo/7xdiMqTrYt5Sm/JLSGLgiXL1r5X0
         t5PmJc5wIe2IHJZQTuSWHC6MD+V0GC/ZblTYBUl0Mus3dJ0EGcHpO1HZpEnpT6debuCv
         DaJw==
X-Gm-Message-State: AOJu0YyEON/EE4lB5dFcIFtSU90RK8NQx9lGFTaW6DJeTpbvBvz3+28x
	vu5D06by2BqnVGnEbozvupJSBoFSwjFlg3UkdHsXZBgu61WH/gSNfPs4z1aEnSwiR9N42T4L9dw
	In65B+Q0Doh9qIoMaCG82aoCtBvK5p6Ju+tTpNgf5/A==
X-Gm-Gg: ASbGncs1l2NXqgwMSXMydCcilupo6VbWNzAqIohSsCOFSqSnepn4h600Q0x/eC1o6N7
	AXZhHBIUD/2V8fsCX9xANzIX6dJpbNSqCZrrcgs1bDSPwYzheM7BiIFn1nxLDIQMm9NzSZk+tXw
	PvHaTLS3VjrqUUU59gchXv7qvxcSMkHGOzC5TERtsJTRiT6PY=
X-Google-Smtp-Source: AGHT+IHxExE2cdLv+F26jySesYOCI3p8f/gNiwBgHKNCPp08MuoxsJMxTzSFP3KxW1rcQhiSTnxsBDgPjTiPtrYEQto=
X-Received: by 2002:ac2:4e07:0:b0:549:6451:7e76 with SMTP id
 2adb3069b0e04-550e71d62ccmr6794058e87.33.1747813684405; Wed, 21 May 2025
 00:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250513180229.7494-1-graf@amazon.com>
In-Reply-To: <20250513180229.7494-1-graf@amazon.com>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Wed, 21 May 2025 15:47:28 +0800
X-Gm-Features: AX0GCFsMklwHXhUs4us3A-K1JDEKVbThrMAaKT42YthmaZQNAErq8P-7k4I5Nw4
Message-ID: <CACSyD1OU1zjvc2YdQpi-F_qZ0EWyb6jLNODJkRDPQa6m1eObJg@mail.gmail.com>
Subject: Re: [External] [PATCH v3] kexec: Enable CMA based contiguous allocation
To: Alexander Graf <graf@amazon.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, nh-open-source@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250521_004811_052853_0409CF5D 
X-CRM114-Status: GOOD (  55.88  )
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

On Wed, May 14, 2025 at 2:40=E2=80=AFAM Alexander Graf <graf@amazon.com> wr=
ote:
>
> When booting a new kernel with kexec_file, the kernel picks a target
> location that the kernel should live at, then allocates random pages,
> checks whether any of those patches magically happens to coincide with
> a target address range and if so, uses them for that range.
>
> For every page allocated this way, it then creates a page list that the
> relocation code - code that executes while all CPUs are off and we are
> just about to jump into the new kernel - copies to their final memory
> location. We can not put them there before, because chances are pretty
> good that at least some page in the target range is already in use by
> the currently running Linux environment. Copying is happening from a
> single CPU at RAM rate, which takes around 4-50 ms per 100 MiB.
>
> All of this is inefficient and error prone.
>
> To successfully kexec, we need to quiesce all devices of the outgoing
> kernel so they don't scribble over the new kernel's memory. We have seen
> cases where that does not happen properly (*cough* GIC *cough*) and hence
> the new kernel was corrupted. This started a month long journey to root
> cause failing kexecs to eventually see memory corruption, because the new
> kernel was corrupted severely enough that it could not emit output to
> tell us about the fact that it was corrupted. By allocating memory for th=
e
> next kernel from a memory range that is guaranteed scribbling free, we ca=
n
> boot the next kernel up to a point where it is at least able to detect
> corruption and maybe even stop it before it becomes severe. This increase=
s
> the chance for successful kexecs.
>
> Since kexec got introduced, Linux has gained the CMA framework which
> can perform physically contiguous memory mappings, while keeping that
> memory available for movable memory when it is not needed for contiguous
> allocations. The default CMA allocator is for DMA allocations.
>
> This patch adds logic to the kexec file loader to attempt to place the
> target payload at a location allocated from CMA. If successful, it uses
> that memory range directly instead of creating copy instructions during
> the hot phase. To ensure that there is a safety net in case anything goes
> wrong with the CMA allocation, it also adds a flag for user space to forc=
e
> disable CMA allocations.
>
> Using CMA allocations has two advantages:
>
>   1) Faster by 4-50 ms per 100 MiB. There is no more need to copy in the
>      hot phase.
>   2) More robust. Even if by accident some page is still in use for DMA,
>      the new kernel image will be safe from that access because it reside=
s
>      in a memory region that is considered allocated in the old kernel an=
d
>      has a chance to reinitialize that component.
>
> Signed-off-by: Alexander Graf <graf@amazon.com>
>
> ---
>
> v1 -> v2:
>
>   - Clarify patch description
>   - Move cma pointer out of kexec_segment. That is a sneaky UAPI struct w=
e
>     can not modify. Fixes non kexec_file path
>   - Coding style
>   - Move memset(0) to only clear remainder
>   - Move kexec_alloc_contig() into kexec_locate_mem_hole(). Makes the cod=
e
>     flow easier to read.
>   - Sanitize return values
>
> v2 -> v3:
>
>   - Fix refactoring bug which meant we never exercised the new code path
> ---
>  arch/riscv/kernel/elf_kexec.c |   1 +
>  include/linux/kexec.h         |  10 ++++
>  include/uapi/linux/kexec.h    |   1 +
>  kernel/kexec.c                |   2 +-
>  kernel/kexec_core.c           | 100 +++++++++++++++++++++++++++++++---
>  kernel/kexec_file.c           |  47 +++++++++++++++-
>  kernel/kexec_internal.h       |   2 +-
>  7 files changed, 152 insertions(+), 11 deletions(-)
>
> diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.=
c
> index e783a72d051f..d81647c98c92 100644
> --- a/arch/riscv/kernel/elf_kexec.c
> +++ b/arch/riscv/kernel/elf_kexec.c
> @@ -109,6 +109,7 @@ static int elf_find_pbase(struct kimage *image, unsig=
ned long kernel_len,
>         kbuf.mem =3D KEXEC_BUF_MEM_UNKNOWN;
>         kbuf.memsz =3D ALIGN(kernel_len, PAGE_SIZE);
>         kbuf.top_down =3D false;
> +       kbuf.cma =3D NULL;
>         ret =3D arch_kexec_locate_mem_hole(&kbuf);
>         if (!ret) {
>                 *old_pbase =3D lowest_paddr;
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index c8971861521a..7821b23bd1e9 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -75,6 +75,12 @@ extern note_buf_t __percpu *crash_notes;
>
>  typedef unsigned long kimage_entry_t;
>
> +/*
> + * This is a copy of the UAPI struct kexec_segment and must be identical
> + * to it because it gets copied straight from user space into kernel
> + * memory. Do not modify this structure unless you change the way segmen=
ts
> + * get ingested from user space.
> + */
>  struct kexec_segment {
>         /*
>          * This pointer can point to user memory if kexec_load() system
> @@ -169,6 +175,7 @@ int kexec_image_post_load_cleanup_default(struct kima=
ge *image);
>   * @buf_min:   The buffer can't be placed below this address.
>   * @buf_max:   The buffer can't be placed above this address.
>   * @top_down:  Allocate from top of memory.
> + * @cma:       CMA page if the buffer is backed by CMA.
>   */
>  struct kexec_buf {
>         struct kimage *image;
> @@ -180,6 +187,7 @@ struct kexec_buf {
>         unsigned long buf_min;
>         unsigned long buf_max;
>         bool top_down;
> +       struct page *cma;
>  };
>
>  int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf);
> @@ -310,6 +318,7 @@ struct kimage {
>
>         unsigned long nr_segments;
>         struct kexec_segment segment[KEXEC_SEGMENT_MAX];
> +       struct page *segment_cma[KEXEC_SEGMENT_MAX];
>
>         struct list_head control_pages;
>         struct list_head dest_pages;
> @@ -331,6 +340,7 @@ struct kimage {
>          */
>         unsigned int hotplug_support:1;
>  #endif
> +       unsigned int no_cma:1;
>
>  #ifdef ARCH_HAS_KIMAGE_ARCH
>         struct kimage_arch arch;
> diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
> index 5ae1741ea8ea..8958ebfcff94 100644
> --- a/include/uapi/linux/kexec.h
> +++ b/include/uapi/linux/kexec.h
> @@ -27,6 +27,7 @@
>  #define KEXEC_FILE_ON_CRASH    0x00000002
>  #define KEXEC_FILE_NO_INITRAMFS        0x00000004
>  #define KEXEC_FILE_DEBUG       0x00000008
> +#define KEXEC_FILE_NO_CMA      0x00000010
>
>  /* These values match the ELF architecture values.
>   * Unless there is a good reason that should continue to be the case.
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index a6b3f96bb50c..28008e3d462e 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -152,7 +152,7 @@ static int do_kexec_load(unsigned long entry, unsigne=
d long nr_segments,
>                 goto out;
>
>         for (i =3D 0; i < nr_segments; i++) {
> -               ret =3D kimage_load_segment(image, &image->segment[i]);
> +               ret =3D kimage_load_segment(image, i);
>                 if (ret)
>                         goto out;
>         }
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 3e62b944c883..b5b680dd1796 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -40,6 +40,7 @@
>  #include <linux/hugetlb.h>
>  #include <linux/objtool.h>
>  #include <linux/kmsg_dump.h>
> +#include <linux/dma-map-ops.h>
>
>  #include <asm/page.h>
>  #include <asm/sections.h>
> @@ -553,6 +554,24 @@ static void kimage_free_entry(kimage_entry_t entry)
>         kimage_free_pages(page);
>  }
>
> +static void kimage_free_cma(struct kimage *image)
> +{
> +       unsigned long i;
> +
> +       for (i =3D 0; i < image->nr_segments; i++) {
> +               struct page *cma =3D image->segment_cma[i];
> +               u32 nr_pages =3D image->segment[i].memsz >> PAGE_SHIFT;
> +
> +               if (!cma)
> +                       continue;
> +
> +               arch_kexec_pre_free_pages(page_address(cma), nr_pages);
> +               dma_release_from_contiguous(NULL, cma, nr_pages);
> +               image->segment_cma[i] =3D NULL;
> +       }
> +
> +}
> +
>  void kimage_free(struct kimage *image)
>  {
>         kimage_entry_t *ptr, entry;
> @@ -591,6 +610,9 @@ void kimage_free(struct kimage *image)
>         /* Free the kexec control pages... */
>         kimage_free_page_list(&image->control_pages);
>
> +       /* Free CMA allocations */
> +       kimage_free_cma(image);
> +
>         /*
>          * Free up any temporary buffers allocated. This might hit if
>          * error occurred much later after buffer allocation.
> @@ -716,9 +738,69 @@ static struct page *kimage_alloc_page(struct kimage =
*image,
>         return page;
>  }
>
> -static int kimage_load_normal_segment(struct kimage *image,
> -                                        struct kexec_segment *segment)
> +static int kimage_load_cma_segment(struct kimage *image, int idx)
> +{
> +       struct kexec_segment *segment =3D &image->segment[idx];
> +       struct page *cma =3D image->segment_cma[idx];
> +       char *ptr =3D page_address(cma);
> +       unsigned long maddr;
> +       size_t ubytes, mbytes;
> +       int result =3D 0;
> +       unsigned char __user *buf =3D NULL;
> +       unsigned char *kbuf =3D NULL;
> +
> +       if (image->file_mode)
> +               kbuf =3D segment->kbuf;
> +       else
> +               buf =3D segment->buf;
> +       ubytes =3D segment->bufsz;
> +       mbytes =3D segment->memsz;
> +       maddr =3D segment->mem;
> +
> +       /* Then copy from source buffer to the CMA one */
> +       while (mbytes) {
> +               size_t uchunk, mchunk;
> +
> +               ptr +=3D maddr & ~PAGE_MASK;
> +               mchunk =3D min_t(size_t, mbytes,
> +                               PAGE_SIZE - (maddr & ~PAGE_MASK));
> +               uchunk =3D min(ubytes, mchunk);
> +
> +               if (uchunk) {
> +                       /* For file based kexec, source pages are in kern=
el memory */
> +                       if (image->file_mode)
> +                               memcpy(ptr, kbuf, uchunk);
> +                       else
> +                               result =3D copy_from_user(ptr, buf, uchun=
k);
> +                       ubytes -=3D uchunk;
> +                       if (image->file_mode)
> +                               kbuf +=3D uchunk;
> +                       else
> +                               buf +=3D uchunk;
> +               }
> +
> +               if (result) {
> +                       result =3D -EFAULT;
> +                       goto out;
> +               }
> +
> +               ptr    +=3D mchunk;
> +               maddr  +=3D mchunk;
> +               mbytes -=3D mchunk;
> +
> +               cond_resched();
> +       }
> +
> +       /* Clear any remainder */
> +       memset(ptr, 0, mbytes);
> +
> +out:
> +       return result;
> +}
> +
> +static int kimage_load_normal_segment(struct kimage *image, int idx)
>  {
> +       struct kexec_segment *segment =3D &image->segment[idx];
>         unsigned long maddr;
>         size_t ubytes, mbytes;
>         int result;
> @@ -733,6 +815,9 @@ static int kimage_load_normal_segment(struct kimage *=
image,
>         mbytes =3D segment->memsz;
>         maddr =3D segment->mem;
>
> +       if (image->segment_cma[idx])
> +               return kimage_load_cma_segment(image, idx);
> +
>         result =3D kimage_set_destination(image, maddr);
>         if (result < 0)
>                 goto out;
> @@ -787,13 +872,13 @@ static int kimage_load_normal_segment(struct kimage=
 *image,
>  }
>
>  #ifdef CONFIG_CRASH_DUMP
> -static int kimage_load_crash_segment(struct kimage *image,
> -                                       struct kexec_segment *segment)
> +static int kimage_load_crash_segment(struct kimage *image, int idx)
>  {
>         /* For crash dumps kernels we simply copy the data from
>          * user space to it's destination.
>          * We do things a page at a time for the sake of kmap.
>          */
> +       struct kexec_segment *segment =3D &image->segment[idx];
>         unsigned long maddr;
>         size_t ubytes, mbytes;
>         int result;
> @@ -858,18 +943,17 @@ static int kimage_load_crash_segment(struct kimage =
*image,
>  }
>  #endif
>
> -int kimage_load_segment(struct kimage *image,
> -                               struct kexec_segment *segment)
> +int kimage_load_segment(struct kimage *image, int idx)
>  {
>         int result =3D -ENOMEM;
>
>         switch (image->type) {
>         case KEXEC_TYPE_DEFAULT:
> -               result =3D kimage_load_normal_segment(image, segment);
> +               result =3D kimage_load_normal_segment(image, idx);
>                 break;
>  #ifdef CONFIG_CRASH_DUMP
>         case KEXEC_TYPE_CRASH:
> -               result =3D kimage_load_crash_segment(image, segment);
> +               result =3D kimage_load_crash_segment(image, idx);
>                 break;
>  #endif
>         }
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index fba686487e3b..916beae68fb6 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -27,6 +27,7 @@
>  #include <linux/kernel_read_file.h>
>  #include <linux/syscalls.h>
>  #include <linux/vmalloc.h>
> +#include <linux/dma-map-ops.h>
>  #include "kexec_internal.h"
>
>  #ifdef CONFIG_KEXEC_SIG
> @@ -230,6 +231,8 @@ kimage_file_prepare_segments(struct kimage *image, in=
t kernel_fd, int initrd_fd,
>                 ret =3D 0;
>         }
>
> +       image->no_cma =3D !!(flags & KEXEC_FILE_NO_CMA);
> +
>         if (cmdline_len) {
>                 image->cmdline_buf =3D memdup_user(cmdline_ptr, cmdline_l=
en);
>                 if (IS_ERR(image->cmdline_buf)) {
> @@ -406,7 +409,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int,=
 initrd_fd,
>                               i, ksegment->buf, ksegment->bufsz, ksegment=
->mem,
>                               ksegment->memsz);
>
> -               ret =3D kimage_load_segment(image, &image->segment[i]);
> +               ret =3D kimage_load_segment(image, i);
>                 if (ret)
>                         goto out;
>         }
> @@ -632,6 +635,39 @@ static int kexec_walk_resources(struct kexec_buf *kb=
uf,
>                 return walk_system_ram_res(0, ULONG_MAX, kbuf, func);
>  }
>
> +static int kexec_alloc_contig(struct kexec_buf *kbuf)
> +{
> +       size_t nr_pages =3D kbuf->memsz >> PAGE_SHIFT;
> +       unsigned long mem;
> +       struct page *p;
> +
> +       /* User space disabled CMA allocations, bail out. */
> +       if (kbuf->image->no_cma)
> +               return -EPERM;
> +
> +       p =3D dma_alloc_from_contiguous(NULL, nr_pages, get_order(kbuf->b=
uf_align), true);
> +       if (!p)
> +               return -ENOMEM;
> +
> +       pr_debug("allocated %zu DMA pages at 0x%lx", nr_pages, page_to_bo=
ot_pfn(p));
> +
> +       mem =3D page_to_boot_pfn(p) << PAGE_SHIFT;
> +
> +       if (kimage_is_destination_range(kbuf->image, mem, mem + kbuf->mem=
sz)) {
> +               /* Our region is already in use by a statically defined o=
ne. Bail out. */
> +               pr_debug("CMA overlaps existing mem: 0x%lx+0x%lx\n", mem,=
 kbuf->memsz);
> +               dma_release_from_contiguous(NULL, p, nr_pages);
> +               return -EBUSY;
> +       }
> +
> +       kbuf->mem =3D page_to_boot_pfn(p) << PAGE_SHIFT;
> +       kbuf->cma =3D p;
> +
> +       arch_kexec_post_alloc_pages(page_address(p), (int)nr_pages, 0);
> +
> +       return 0;
> +}
> +
>  /**
>   * kexec_locate_mem_hole - find free memory for the purgatory or the nex=
t kernel
>   * @kbuf:      Parameters for the memory search.
> @@ -648,6 +684,13 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
>         if (kbuf->mem !=3D KEXEC_BUF_MEM_UNKNOWN)
>                 return 0;
>
> +       /*
> +        * Try to find a free physically contiguous block of memory first=
. With that, we
> +        * can avoid any copying at kexec time.
> +        */
> +       if (!kexec_alloc_contig(kbuf))
> +               return 0;

IIUC, The kexec_locate_mem_hole() function is also used in
the KEXEC_TYPE_CRASH kimage, but kexec_alloc_contig() does not skip it.
This can cause kdump to fail and lead to CMA memory leakage.

So I ran some tests, as listed below:
The CMA memory decreases with each execution of the kdump-config
reload operation.

/home/hezhongkun.hzk# kdump-config reload
unloaded kdump kernel.
Creating symlink /var/lib/kdump/vmlinuz.
Creating symlink /var/lib/kdump/initrd.img.
kexec_file_load failed: Cannot assign requested address
failed to load kdump kernel ... failed!

[ 1387.536346] kexec_file: allocated 1817 DMA pages at 0x11b16e
[ 1399.147677] kexec_file: allocated 113 DMA pages at 0x119087
[ 1399.148915] kexec_file: allocated 5 DMA pages at 0x1140f8
[ 1399.150266] kexec_file: allocated 2 DMA pages at 0x1118fd
[ 1399.151474] kexec_file: allocated 8302 DMA pages at 0x11b900

/home/hezhongkun.hzk# cat /proc/meminfo | grep Cma
CmaTotal:        1048576 kB
CmaFree:          679972 kB
/home/hezhongkun.hzk# cat /proc/meminfo | grep Cma
CmaTotal:        1048576 kB
CmaFree:          639016 kB
/home/hezhongkun.hzk# cat /proc/meminfo | grep Cma
CmaTotal:        1048576 kB
CmaFree:          557104 kB

cat /proc/meminfo | grep Cma
CmaTotal:        1048576 kB
CmaFree:          557104 kB

> +
>         if (!IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK))
>                 ret =3D kexec_walk_resources(kbuf, locate_mem_hole_callba=
ck);
>         else
> @@ -693,6 +736,7 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
>         /* Ensure minimum alignment needed for segments. */
>         kbuf->memsz =3D ALIGN(kbuf->memsz, PAGE_SIZE);
>         kbuf->buf_align =3D max(kbuf->buf_align, PAGE_SIZE);
> +       kbuf->cma =3D NULL;
>
>         /* Walk the RAM ranges and allocate a suitable range for the buff=
er */
>         ret =3D arch_kexec_locate_mem_hole(kbuf);
> @@ -705,6 +749,7 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
>         ksegment->bufsz =3D kbuf->bufsz;
>         ksegment->mem =3D kbuf->mem;
>         ksegment->memsz =3D kbuf->memsz;
> +       kbuf->image->segment_cma[kbuf->image->nr_segments] =3D kbuf->cma;
>         kbuf->image->nr_segments++;
>         return 0;
>  }
> diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
> index d35d9792402d..29e6cebe0c43 100644
> --- a/kernel/kexec_internal.h
> +++ b/kernel/kexec_internal.h
> @@ -10,7 +10,7 @@ struct kimage *do_kimage_alloc_init(void);
>  int sanity_check_segment_list(struct kimage *image);
>  void kimage_free_page_list(struct list_head *list);
>  void kimage_free(struct kimage *image);
> -int kimage_load_segment(struct kimage *image, struct kexec_segment *segm=
ent);
> +int kimage_load_segment(struct kimage *image, int idx);
>  void kimage_terminate(struct kimage *image);
>  int kimage_is_destination_range(struct kimage *image,
>                                 unsigned long start, unsigned long end);
> --
> 2.34.1
>
>
>
>
> Amazon Web Services Development Center Germany GmbH
> Tamara-Danz-Str. 13
> 10243 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
> Sitz: Berlin
> Ust-ID: DE 365 538 597
>
>

