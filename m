Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F6BC4167B
	for <kexec@archiver.kernel.org>; Mon, 27 Nov 2023 02:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OsVAvJIZmPvfNkUvYmTJm4b5qg8uyxFhMvrcSa3T2yg=; b=mwcKefYvoR4CKU
	AHL4SV+x96PlpkoHnNVrx7z0af7+EiOlQeVnkENPbdj48Lasf1AyJj7cJZRB8jll5aywJ6JOLfrun
	35gHxCQi+xqhDNqPP7V3je9ghYCudldJPrKJl0328NFgC39Y1wgtupRTHQ2mFpjnhfJ8PVfOd5pjt
	k7Wdfn7J24HEFmTVHFsvWCjU3+Y7PswFslT7zVZlXCKO5xeSjMrGDPBurvg6Ne0yYV+VHsn0UhDiT
	74ljqvEyjgfL6RcdsZHO2rJGfqMWLiCr6WjaHmeWyMDurJIEKfD2TTYlFrpSRwdLQBWCayK/PczqK
	2aYhqCR9DQNuhq36TALA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7RUT-000p3o-2L;
	Mon, 27 Nov 2023 02:36:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7RUO-000ozP-1W
	for kexec@lists.infradead.org;
	Mon, 27 Nov 2023 02:36:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701052604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OnlAd81AtR7tfT/hg0uW7MRDEXbpY2eZhaQtTCXoigg=;
	b=DcgiUM2fDdTvfMzJqPj46nr+vkStp90sKaJP/s8/NFw3SK4quNU9mhUBq1FsCaXttabciO
	NrA/gZ+d1nExeyZWaSYwh+HPGtdPBWtF5ujigQ9nedEI4J6hUE5AYLqDOEflgwj7uqkueh
	mQR5X/QKTpRIfukEQTWceQyUZ4f0SWs=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-5RimiEL0OLqkNdTOBt05Wg-1; Sun, 26 Nov 2023 21:36:43 -0500
X-MC-Unique: 5RimiEL0OLqkNdTOBt05Wg-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7b395875bd0so22829139f.0
        for <kexec@lists.infradead.org>; Sun, 26 Nov 2023 18:36:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701052602; x=1701657402;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OnlAd81AtR7tfT/hg0uW7MRDEXbpY2eZhaQtTCXoigg=;
        b=Gt0VV1EnziOcIjtlsLJkaYK6gKLW3iUV1zBRaEjPKWwtwMpfZhDGd6XKCU7MqM6qnO
         6lKiwHk3fgXYJ1z8k43Y0/3eDgipFK+82axHV0D+urFiQCPdnoZMxO8eAmTXL1qVTTtB
         sc9WGjO3jGhhdwv5Gat+4KO+uH32aFd2nBG6cA9v6PMmjmYwF/nBCmikhZvoTOnaYj3/
         s6embh2+RWx+di1LMXWOt2nZ4udDK4kQ2WedfrUJY6CChMY5qXdxGyzPPwdWB2oEahs1
         VTEvmmSubUZRLF0wvtkUVPWLiosO6mxAIP85HRrtua16SyDiMeruUq4zb0c/gWRb6g8g
         ygfw==
X-Gm-Message-State: AOJu0YxEFW8rabcrdbd7XmV3z1sjsLFR4iEIae7bXLPx49Gqb4fgUr6d
	6e4lyTFQn9dDhSE+NvXCprZukJYaQI9aRM9pn/wWrlT+rZaiPwnOu1ueRBOoNfuc35PuQA5beZR
	Tn1kPbZq0POxCtyNxsP3CmK56uPc4VOvLnNPK592J0A3z
X-Received: by 2002:a92:c565:0:b0:35c:4642:c08b with SMTP id b5-20020a92c565000000b0035c4642c08bmr11435541ilj.1.1701052602308;
        Sun, 26 Nov 2023 18:36:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0kyZiUDf1aysIt/+dtRmdxCfqO0u+MbdJczKaVmKtbhKArPOHYj7K0Ej+Zt83JGZh9jvsYTtClRMpVLqwBpU=
X-Received: by 2002:a92:c565:0:b0:35c:4642:c08b with SMTP id
 b5-20020a92c565000000b0035c4642c08bmr11435533ilj.1.1701052601983; Sun, 26 Nov
 2023 18:36:41 -0800 (PST)
MIME-Version: 1.0
References: <20231125065232.116319-1-wangrui@loongson.cn> <CALu+AoRThqZWGv6+-d0PUFA2XNL1g2-H5HrxHGR5OrTerfpbiQ@mail.gmail.com>
In-Reply-To: <CALu+AoRThqZWGv6+-d0PUFA2XNL1g2-H5HrxHGR5OrTerfpbiQ@mail.gmail.com>
From: RuiRui Yang <ruyang@redhat.com>
Date: Mon, 27 Nov 2023 10:36:30 +0800
Message-ID: <CALu+AoRVKT+E0TdRRQ3GcxeM9r5BHNE7pz-dN6pUV_MCnviYZg@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: Load vmlinux.efi to the link address
To: WANG Rui <wangrui@loongson.cn>
Cc: kexec@lists.infradead.org, Huacai Chen <chenhuacai@kernel.org>, hev <r@hev.cc>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231126_183648_679298_594DEEB3 
X-CRM114-Status: GOOD (  33.40  )
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

On Mon, 27 Nov 2023 at 09:53, RuiRui Yang <ruyang@redhat.com> wrote:
>
> On Sat, 25 Nov 2023 at 14:54, WANG Rui <wangrui@loongson.cn> wrote:
> >
> > Currently, kexec loads vmlinux.efi to address 0 instead of the link
> > address. This causes kexec to fail to boot the new vmlinux.efi on qemu.
> >
> >   pei_loongarch_load: kernel_segment: 0000000000000000
> >   pei_loongarch_load: kernel_entry:   00000000013f1000
> >   pei_loongarch_load: image_size:     0000000001ca0000
> >   pei_loongarch_load: text_offset:    0000000000200000
> >   pei_loongarch_load: phys_offset:    0000000000000000
> >   pei_loongarch_load: PE format:      yes
> >   loongarch_load_other_segments:333: command_line: kexec console=ttyS0,115200
> >   kexec_load: entry = 0x13f1000 flags = 0x1020000
> >   nr_segments = 2
> >   segment[0].buf   = 0x7fffeea38010
> >   segment[0].bufsz = 0x1b55200
> >   segment[0].mem   = (nil)
> >   segment[0].memsz = 0x1ca0000
> >   segment[1].buf   = 0x5555570940b0
> >   segment[1].bufsz = 0x200
> >   segment[1].mem   = 0x1ca0000
> >   segment[1].memsz = 0x4000
> >
> > This patch constrains the range of the kernel segment by `hole_min`
> > and `hole_max` to place vmlinux.efi exactly at the link address.
> >
> >   pei_loongarch_load: kernel_segment: 0000000000200000
> >   pei_loongarch_load: kernel_entry:   00000000013f1000
> >   pei_loongarch_load: image_size:     0000000001ca0000
> >   pei_loongarch_load: text_offset:    0000000000200000
> >   pei_loongarch_load: phys_offset:    0000000000000000
> >   pei_loongarch_load: PE format:      yes
> >   loongarch_load_other_segments:339: command_line: kexec console=ttyS0,115200
> >   kexec_load: entry = 0x13f1000 flags = 0x1020000
> >   nr_segments = 2
> >   segment[0].buf   = 0x7ffff2028010
> >   segment[0].bufsz = 0x1b55200
> >   segment[0].mem   = 0x200000
> >   segment[0].memsz = 0x1ca0000
> >   segment[1].buf   = 0x555557498098
> >   segment[1].bufsz = 0x200
> >   segment[1].mem   = 0x1ea0000
> >   segment[1].memsz = 0x4000
> >
> > Signed-off-by: WANG Rui <wangrui@loongson.cn>
> > ---
> >
> > v1->v2:
> >  * Fix the issue preventing it from working on the physical machine.
> >
> >  kexec/arch/loongarch/kexec-loongarch.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/kexec/arch/loongarch/kexec-loongarch.c b/kexec/arch/loongarch/kexec-loongarch.c
> > index 62ff8fd..32a42d2 100644
> > --- a/kexec/arch/loongarch/kexec-loongarch.c
> > +++ b/kexec/arch/loongarch/kexec-loongarch.c
> > @@ -265,9 +265,13 @@ unsigned long loongarch_locate_kernel_segment(struct kexec_info *info)
> >                         hole = ULONG_MAX;
> >                 }
> >         } else {
> > -               hole = locate_hole(info,
> > -                       loongarch_mem.text_offset + loongarch_mem.image_size,
> > -                       MiB(1), 0, ULONG_MAX, 1);
> > +               unsigned long hole_min;
> > +               unsigned long hole_max;
> > +
> > +               hole_min = loongarch_mem.text_offset;
> > +               hole_max = hole_min + loongarch_mem.image_size;
> > +               hole = locate_hole(info, loongarch_mem.image_size,
> > +                       MiB(1), hole_min, hole_max, 1);
> >
> >                 if (hole == ULONG_MAX)
> >                         dbgprintf("%s: locate_hole failed\n", __func__);
>
> Hi,
>
> Previously when I played with the zboot kernel on a kvm guest I
> noticed this issue, but I found that the 1st 2M memory is memblock
> reserved but it is not shown in /proc/iomem as reserved, I suspect the
> 1st 2M is not usable for some arch specific reason but I was not sure.
>   Below patch can fix it but due to my rusty knowledge of loongarch I

Correct about my English wording a bit, I meant about rusty knowledge
of kexec details and newbish loongarch knowledge,
BTW, the webmail often randomly choose the sender email, I usually use
another email for community, that is Dave Young <dyoung@redhat.com>,
same person ;)

Anyway, since this is loongarch specific, it would be better to leave
you guys the arch people to see how to fix it better.

> did not send it out. I suspect even if the locate_hole avoids the
> wrong memory, in the 2nd kernel it could still access it.  Correct?
>
> Index: linux/arch/loongarch/kernel/mem.c
> ===================================================================
> --- linux.orig/arch/loongarch/kernel/mem.c      2023-06-02
> 10:24:09.633593320 +0800
> +++ linux/arch/loongarch/kernel/mem.c   2023-10-05 15:27:05.609455460 +0800
> @@ -52,8 +52,8 @@
>         memblock_set_current_limit(PFN_PHYS(max_low_pfn));
>         memblock_set_node(0, PHYS_ADDR_MAX, &memblock.memory, 0);
>
> -       /* Reserve the first 2MB */
> -       memblock_reserve(PHYS_OFFSET, 0x200000);
> +       /* Mark the first 2MB as nomap */
> +       memblock_mark_nomap(PHYS_OFFSET, 0x200000);
>
>         /* Reserve the kernel text/data/bss */
>         memblock_reserve(__pa_symbol(&_text),
>
>
> > --
> > 2.42.0
> >
> >
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> >


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
