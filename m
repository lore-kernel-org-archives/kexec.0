Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14A7C4167B
	for <kexec@archiver.kernel.org>; Mon, 27 Nov 2023 01:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OYBa2cwHHydG2fnSxU6G9djY5/Gt4NnYE6MWDG3mLMs=; b=QJqH80rmWUhUwL
	oLqflw/MC/WkJT0Ld8DMVfeLpbQutUAx7KeSj00zjIq5630oFOKJvPo81GrmMzdmSn+m9UnByVdNg
	ZuDxk6A+M5kyZBHPEAVEase53As5H1ZTtJWtGRuwwoJyC1dZB/UW08d8T1y9UM+7Bfrx18w1/8+Ol
	GjuDKpuV/8GFnL4r5pA/a/7crBFTC+WiiCJT50I7XPjKSwcVmiMlHSd/hDdflwHJLwEwlXXDeGqny
	yMrpDEhf6DyblCLT37N1U72EGx5uoG1x7Z5LqdZe3U/oZ4iD+hNCePUz49th7hFctxL4U1Cn0V/yE
	mPA6aNi6j6j+4Jnsc8ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7QqX-000T9V-1K;
	Mon, 27 Nov 2023 01:55:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7QqP-000T5P-2C
	for kexec@lists.infradead.org;
	Mon, 27 Nov 2023 01:55:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701050127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ctth5Nh+2rAzjhGGA8ryb0kGXerLCZUwTpt4ADWW7qk=;
	b=K5uUik3VJp90FhP+S5AcVuCJUFtRzDtukzqRsiKlogKQihbr3MAy6THnrClPPSBKovwxLQ
	sxjXeJIyskPPO37K9MZ+40zfHSkPPbiVbSFqzIl7dKv+a3CRmodzzCH/O0s3voFej3gXaN
	UZtElsRbfZ8lMKSxZ7XqaV+Egu6SMXg=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-EVifhS25N1-7Yk-wOsA2pg-1; Sun, 26 Nov 2023 20:53:45 -0500
X-MC-Unique: EVifhS25N1-7Yk-wOsA2pg-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-35b354b5b6cso3151545ab.0
        for <kexec@lists.infradead.org>; Sun, 26 Nov 2023 17:53:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701050024; x=1701654824;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ctth5Nh+2rAzjhGGA8ryb0kGXerLCZUwTpt4ADWW7qk=;
        b=Pno79+SgR9KQVAlBQgI57k1OH5zA0J+JmgfMg4JqSixe7hOm5LLs67wlLrl5y+kFxE
         RLVQWVrSbXthaxEmTvTxSqNGoP+sLg/m/pRmDfvOpd4YVWGtkf2yHgPvPGSSwUJNtaN+
         sFJzK5lMxuvWQkOCBMIqBBPgLahHBk+PLH4kGOLy7kuSCLisSgrv4KJUzE++upLQ4gap
         N1GT/s42MYe3xMNZJsyuVBslD+G7dnhPxaG85IM6p6AP0F3oY5YI7iDXS2yGvlyAVfY8
         8YQg61CFESadPjynZoC0GY/G1AGfRiLiLQC4W4QImV7eoLikjF/LtbZuB/IzgNKKR0vg
         foLQ==
X-Gm-Message-State: AOJu0YzJN9dkVVrvIL7e1hoq/i2ruRnuIUjK5jQherhbbfKj36IZXzDP
	nw/6buajqK2uPN2Kqzzk7ZrV/a3ty7iW6u6Bm1PhqpGWP82lMyUV3jNJIGWqhF2V7uJQ367rYeS
	AOdE8pxrVGzDyxdThZfY16ffxesKtcEkIkMWb
X-Received: by 2002:a92:c84b:0:b0:35c:baec:750c with SMTP id b11-20020a92c84b000000b0035cbaec750cmr2348005ilq.1.1701050024423;
        Sun, 26 Nov 2023 17:53:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvRXqWMTsyYGdo5bH08PjLpalZgkVqh/Oiq68CjRnVbN9lfdIy7dIbS/o9j2fLiXMwf2q+8pEsEQnmn3+LRXs=
X-Received: by 2002:a92:c84b:0:b0:35c:baec:750c with SMTP id
 b11-20020a92c84b000000b0035cbaec750cmr2347985ilq.1.1701050024022; Sun, 26 Nov
 2023 17:53:44 -0800 (PST)
MIME-Version: 1.0
References: <20231125065232.116319-1-wangrui@loongson.cn>
In-Reply-To: <20231125065232.116319-1-wangrui@loongson.cn>
From: RuiRui Yang <ruyang@redhat.com>
Date: Mon, 27 Nov 2023 09:53:32 +0800
Message-ID: <CALu+AoRThqZWGv6+-d0PUFA2XNL1g2-H5HrxHGR5OrTerfpbiQ@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: Load vmlinux.efi to the link address
To: WANG Rui <wangrui@loongson.cn>
Cc: kexec@lists.infradead.org, Huacai Chen <chenhuacai@kernel.org>, hev <r@hev.cc>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231126_175530_108535_06A52DC5 
X-CRM114-Status: GOOD (  26.00  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Sat, 25 Nov 2023 at 14:54, WANG Rui <wangrui@loongson.cn> wrote:
>
> Currently, kexec loads vmlinux.efi to address 0 instead of the link
> address. This causes kexec to fail to boot the new vmlinux.efi on qemu.
>
>   pei_loongarch_load: kernel_segment: 0000000000000000
>   pei_loongarch_load: kernel_entry:   00000000013f1000
>   pei_loongarch_load: image_size:     0000000001ca0000
>   pei_loongarch_load: text_offset:    0000000000200000
>   pei_loongarch_load: phys_offset:    0000000000000000
>   pei_loongarch_load: PE format:      yes
>   loongarch_load_other_segments:333: command_line: kexec console=ttyS0,115200
>   kexec_load: entry = 0x13f1000 flags = 0x1020000
>   nr_segments = 2
>   segment[0].buf   = 0x7fffeea38010
>   segment[0].bufsz = 0x1b55200
>   segment[0].mem   = (nil)
>   segment[0].memsz = 0x1ca0000
>   segment[1].buf   = 0x5555570940b0
>   segment[1].bufsz = 0x200
>   segment[1].mem   = 0x1ca0000
>   segment[1].memsz = 0x4000
>
> This patch constrains the range of the kernel segment by `hole_min`
> and `hole_max` to place vmlinux.efi exactly at the link address.
>
>   pei_loongarch_load: kernel_segment: 0000000000200000
>   pei_loongarch_load: kernel_entry:   00000000013f1000
>   pei_loongarch_load: image_size:     0000000001ca0000
>   pei_loongarch_load: text_offset:    0000000000200000
>   pei_loongarch_load: phys_offset:    0000000000000000
>   pei_loongarch_load: PE format:      yes
>   loongarch_load_other_segments:339: command_line: kexec console=ttyS0,115200
>   kexec_load: entry = 0x13f1000 flags = 0x1020000
>   nr_segments = 2
>   segment[0].buf   = 0x7ffff2028010
>   segment[0].bufsz = 0x1b55200
>   segment[0].mem   = 0x200000
>   segment[0].memsz = 0x1ca0000
>   segment[1].buf   = 0x555557498098
>   segment[1].bufsz = 0x200
>   segment[1].mem   = 0x1ea0000
>   segment[1].memsz = 0x4000
>
> Signed-off-by: WANG Rui <wangrui@loongson.cn>
> ---
>
> v1->v2:
>  * Fix the issue preventing it from working on the physical machine.
>
>  kexec/arch/loongarch/kexec-loongarch.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/kexec/arch/loongarch/kexec-loongarch.c b/kexec/arch/loongarch/kexec-loongarch.c
> index 62ff8fd..32a42d2 100644
> --- a/kexec/arch/loongarch/kexec-loongarch.c
> +++ b/kexec/arch/loongarch/kexec-loongarch.c
> @@ -265,9 +265,13 @@ unsigned long loongarch_locate_kernel_segment(struct kexec_info *info)
>                         hole = ULONG_MAX;
>                 }
>         } else {
> -               hole = locate_hole(info,
> -                       loongarch_mem.text_offset + loongarch_mem.image_size,
> -                       MiB(1), 0, ULONG_MAX, 1);
> +               unsigned long hole_min;
> +               unsigned long hole_max;
> +
> +               hole_min = loongarch_mem.text_offset;
> +               hole_max = hole_min + loongarch_mem.image_size;
> +               hole = locate_hole(info, loongarch_mem.image_size,
> +                       MiB(1), hole_min, hole_max, 1);
>
>                 if (hole == ULONG_MAX)
>                         dbgprintf("%s: locate_hole failed\n", __func__);

Hi,

Previously when I played with the zboot kernel on a kvm guest I
noticed this issue, but I found that the 1st 2M memory is memblock
reserved but it is not shown in /proc/iomem as reserved, I suspect the
1st 2M is not usable for some arch specific reason but I was not sure.
  Below patch can fix it but due to my rusty knowledge of loongarch I
did not send it out. I suspect even if the locate_hole avoids the
wrong memory, in the 2nd kernel it could still access it.  Correct?

Index: linux/arch/loongarch/kernel/mem.c
===================================================================
--- linux.orig/arch/loongarch/kernel/mem.c      2023-06-02
10:24:09.633593320 +0800
+++ linux/arch/loongarch/kernel/mem.c   2023-10-05 15:27:05.609455460 +0800
@@ -52,8 +52,8 @@
        memblock_set_current_limit(PFN_PHYS(max_low_pfn));
        memblock_set_node(0, PHYS_ADDR_MAX, &memblock.memory, 0);

-       /* Reserve the first 2MB */
-       memblock_reserve(PHYS_OFFSET, 0x200000);
+       /* Mark the first 2MB as nomap */
+       memblock_mark_nomap(PHYS_OFFSET, 0x200000);

        /* Reserve the kernel text/data/bss */
        memblock_reserve(__pa_symbol(&_text),


> --
> 2.42.0
>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
